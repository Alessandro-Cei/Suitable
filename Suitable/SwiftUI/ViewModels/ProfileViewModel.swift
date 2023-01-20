//
//  ProfilesViewModel.swift
//  Suitable
//
//  Created by Martina Esposito on 19/01/23.
//

import Foundation

class ProfileViewModel: ObservableObject{

    @Published var profiles: [Profile] = [
        Profile( name: "edbfvsdfv", surname: "etbdvf", birthDate: Date(), image: "ImageProfile", description: "jnpiquewbròsvjbdò jbòwijbrviudb àawoiubrvoub aòwubrovuibd àouwabrvubuwoabruvjbujwbaurbvoubwaeàoòjbdsvjkba òskjbfad vòjkbawkjbreòkjvbaòwjbòrbjvdòajbwsdkjvb nkxòajebròuvbòakjbfòkajsvb", tags: [], role: "IOS Developer", motto: "uhèoauiv", displayName: "regvsfa")
    ]
        
//    @Published var prova : [Profile] = []

    func addProfile(profile: Profile) -> Void {
        self.profiles.append(profile)
//        self.prova.append(profile)

        
    }

}


var profile1 = ProfileViewModel()
