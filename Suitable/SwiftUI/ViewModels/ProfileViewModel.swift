//
//  ProfilesViewModel.swift
//  Suitable
//
//  Created by Martina Esposito on 19/01/23.
//

import Foundation

class ProfileViewModel: ObservableObject{

    @Published var profiles: [Profile] = [
        Profile( name: "Mario", surname: "Rossi", birthDate: Date(), image: "ImageProfile", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.", tags: ["CoreData", "SpriteKit", "UiKit"], role: "IOS Developer", motto: "No one is better than what they believe to be, no one but me", displayName: "")
    ]
        
//    @Published var prova : [Profile] = []

    func addProfile(profile: Profile) -> Void {
        self.profiles.append(profile)
//        self.prova.append(profile)

        
    }

}


var profile1 = ProfileViewModel()
