//
//  HostJoinView.swift
//  Suitable
//
//  Created by Ale on 19/01/23.
//

import SwiftUI

struct HostJoinView: View {
    
    @ObservedObject var SPMCViewModel : SendProfileMultipeerConnectivityViewModel
        
    var body: some View {
        
        if SPMCViewModel.connectedToSession {
            HStack (spacing: 10) {
                ForEach (SPMCViewModel.peers, id: \.self) { peer in
                    Text(peer.displayName)
                }
            }
        } else {
            
            HStack {
                
                Button(action: {
                    SPMCViewModel.host()
                }, label: {
                    Text("Host a Session").underline()
                })
                
                Text(" or ")

                Button(action: {
                    SPMCViewModel.join()
                }, label: {
                    Text("Join a Session").underline()
                })

            }
            
        }
    }
}

struct HostJoinView_Previews: PreviewProvider {
    static var previews: some View {
        HostJoinView(SPMCViewModel: SendProfileMultipeerConnectivityViewModel())
    }
}
