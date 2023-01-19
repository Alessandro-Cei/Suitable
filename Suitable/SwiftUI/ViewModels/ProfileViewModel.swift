//
//  ProfilesViewModel.swift
//  Suitable
//
//  Created by Martina Esposito on 19/01/23.
//

import Foundation

class ProfileViewModel: ObservableObject{

    @Published var profiles: [Profile] = []
        
//    @Published var prova : [Profile] = []

    func addProfile(profile: Profile) -> Void {
        self.profiles.append(profile)
//        self.prova.append(profile)

        
    }

}


var profile1 = ProfileViewModel()
