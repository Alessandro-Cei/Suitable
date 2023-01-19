//
//  MCViewModel.swift
//  ProvaMultiPeerConnectivity
//
//  Created by Yoddikko on 19/01/23.
//

import Foundation
import MultipeerConnectivity
import UIKit

/**
 This is the `SendProfileMultipeerConnectivityViewModel` that manages all the interaction with the MultipeerConnectivity framework. With this ViewModel you can host or join a session and send profiles to the current session.
 
  - Authors: Yoddikko
 
  - Version: 0.1
 */
class SendProfileMultipeerConnectivityViewModel: NSObject, ObservableObject {
    
    
    /**
     This is the name of the service that will let you host or join session with this exact service name.
     
     Once you have created a service you need to go in `info.plist` and add a new string in the `Bonjour services` named as the servie you are creating. Also you need to use this specific naming convention:
     
            _SERVICENAME._tcp
     
     */
    private static let service = "send-profile"
    
    ///The list of all profiles gathered from the MultipeerConnectivity.
    @Published var profiles: [Profile] = []
    
    @Published var peers: [MCPeerID] = []
    
    ///Shows if you are currently connected to a session
    @Published var connectedToSession = false
    
    ///Current device peer name
    let myPeerId = MCPeerID(displayName: UIDevice.current.name)
    
    
    private var advertiserAssistant: MCNearbyServiceAdvertiser?
    private var session: MCSession?
    
    ///Shows if you are currently hosting a session
    private var isHosting = false
    
    
    ///This function let you send the profile in your session
    func send(profile: Profile) {
        let profile = Profile(displayName: myPeerId.displayName, body: profile.body)
        guard
            let session = session,
            let data = profile.body.data(using: .utf8),
            !session.connectedPeers.isEmpty
        else { return }
        
        do {
            try session.send(data, toPeers: session.connectedPeers, with: .reliable)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    //TODO: - Add documentation and refine the function
    func sendHistory(to peer: MCPeerID) {
        let tempFile = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent("messages.data")
        guard let historyData = try? JSONEncoder().encode(profiles) else { return }
        try? historyData.write(to: tempFile)
        session?.sendResource(at: tempFile, withName: "Chat_History", toPeer: peer) { error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    
    ///This function let you join a multipeerconnectivity session
    func join() {
        peers.removeAll()
        profiles.removeAll()
        session = MCSession(peer: myPeerId, securityIdentity: nil, encryptionPreference: .required)
        session?.delegate = self
        guard
            let window = UIApplication.shared.windows.first,
            let session = session
        else { return }
        
        let mcBrowserViewController = MCBrowserViewController(serviceType: SendProfileMultipeerConnectivityViewModel.service, session: session)
        mcBrowserViewController.delegate = self
        window.rootViewController?.present(mcBrowserViewController, animated: true)
    }
    
    ///This function let you host a multipeerconnectivity session
    func host() {
        isHosting = true
        peers.removeAll()
        profiles.removeAll()
        connectedToSession = true
        session = MCSession(peer: myPeerId, securityIdentity: nil, encryptionPreference: .required)
        session?.delegate = self
        advertiserAssistant = MCNearbyServiceAdvertiser(
            peer: myPeerId,
            discoveryInfo: nil,
            serviceType: SendProfileMultipeerConnectivityViewModel.service)
        advertiserAssistant?.delegate = self
        advertiserAssistant?.startAdvertisingPeer()
    }
        
    ///This function let you leave a multipeerconnectivity session
    func leaveSession() {
        isHosting = false
        connectedToSession = false
        advertiserAssistant?.stopAdvertisingPeer()
        profiles.removeAll()
        session = nil
        advertiserAssistant = nil
    }
}

extension SendProfileMultipeerConnectivityViewModel: MCNearbyServiceAdvertiserDelegate {
    func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didReceiveInvitationFromPeer peerID: MCPeerID, withContext context: Data?, invitationHandler: @escaping (Bool, MCSession?) -> Void) {
        invitationHandler(true, session)
    }
}

extension SendProfileMultipeerConnectivityViewModel: MCSessionDelegate {
    func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        guard let message = String(data: data, encoding: .utf8) else { return }
        let chatMessage = Profile(displayName: peerID.displayName, body: message)
        DispatchQueue.main.async {
            self.profiles.append(chatMessage)
        }
    }
    
    func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
        switch state {
        case .connected:
            if !peers.contains(peerID) {
                DispatchQueue.main.async {
                    self.peers.insert(peerID, at: 0)
                }
                if isHosting {
                    sendHistory(to: peerID)
                }
            }
        case .notConnected:
            DispatchQueue.main.async {
                if let index = self.peers.firstIndex(of: peerID) {
                    self.peers.remove(at: index)
                }
                if self.peers.isEmpty && !self.isHosting {
                    self.connectedToSession = false
                }
            }
        case .connecting:
            print("Connecting to: \(peerID.displayName)")
        @unknown default:
            print("Unknown state: \(state)")
        }
    }
    
    func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {}
    
    func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {
        print("Receiving chat history")
    }
    
    func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL?, withError error: Error?) {
        guard
            let localURL = localURL,
            let data = try? Data(contentsOf: localURL),
            let messages = try? JSONDecoder().decode([Profile].self, from: data)
        else { return }
        
        DispatchQueue.main.async {
            self.profiles.insert(contentsOf: messages, at: 0)
        }
    }
}

extension SendProfileMultipeerConnectivityViewModel: MCBrowserViewControllerDelegate {
    func browserViewControllerDidFinish(_ browserViewController: MCBrowserViewController) {
        browserViewController.dismiss(animated: true) {
            self.connectedToSession = true
        }
    }
    
    func browserViewControllerWasCancelled(_ browserViewController: MCBrowserViewController) {
        session?.disconnect()
        browserViewController.dismiss(animated: true)
    }
}


