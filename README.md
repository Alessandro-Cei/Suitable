# # Suitable

# Coding documentation

## Multipeer connectivity

The app allows you to share your profile with other people on the same local network using Apple's **[MultipeerConnectivity framework](https://developer.apple.com/documentation/multipeerconnectivity)**. 
```swift
    import MultipeerConnectivity
```

Before sharing your profile, you must join or host a session using the **MultipeerConnectivity View Model**  

**NOTE**: One very important thing to set up is the "*service*."      This is the name of the service that will allow you to host or participate in sessions with this exact service name. 

In addition to setting this variable in the code, it is necessary to add an element to the info.plist .
In fact, it will be necessary to add a new value of **Bonjur services**. 
The value will have to follow this exact naming convention otherwise sessions will not be started and will return error.

    _NAMEOFTHESERVICE._tcp

But now let's look at the functions within the viewmodel
You can use the function `join()` to open the session list and select which session you want to enter:
```swift
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
 ```
Or you can use the function `host()` to host a session:
 ```swift
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
```

Once you have joined a session you only need to share your profile using the function `send()` :
```swift
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
```


The shared items will populate the **profiles** array in the application of everyone who was in the session
```swift
        @Published var profiles: [Profile] = []
```



# Design documentation

# Future implementations

 - [ ] Data persistency
 - [ ] Nearby Interaction


