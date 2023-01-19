//
//  ProfilesViewModel.swift
//  Suitable
//
//  Created by Martina Esposito on 19/01/23.
//

import Foundation

class ProfileViewModel: ObservableObject{

    @Published var profiles: [Profile] = [
        
        Profile(name: "Nime", surname: "Cognome", birthDate: "", image: "", description: "", tags: [], links: [], backgroundColor: []),
        Profile(name: "Nime", surname: "Cognome", birthDate: "", image: "", description: "", tags: [], links: [], backgroundColor: []),
        Profile(name: "Nime", surname: "Cognome", birthDate: "", image: "", description: "", tags: [], links: [], backgroundColor: []),
        Profile(name: "Nime", surname: "Cognome", birthDate: "", image: "", description: "", tags: [], links: [], backgroundColor: []),
        Profile(name: "Nime", surname: "Cognome", birthDate: "", image: "", description: "", tags: [], links: [], backgroundColor: []),
        Profile(name: "Nime", surname: "Cognome", birthDate: "", image: "", description: "", tags: [], links: [], backgroundColor: [])
    ]

    func addProfile(profile: Profile) -> Void{
        self.profiles.append(profile)
    }

}


var profile1 = ProfileViewModel()
