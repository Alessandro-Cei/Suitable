//
//  ProfileManager.swift
//  Suitable
//
//  Created by Alessandro Cei on 19/01/23.
//

import Foundation
import UIKit

class ProfileManager {
    
    static var shared = ProfileViewModel()
    
    var profiles: [Profile] = [] {
        didSet {
            // The code in this block will be executed whenever the value of myVariable changes
            updateUI()
        }
    }
    func updateUI() {
        // Update the UI in the view controller
        NotificationCenter.default.post(name: .profilesGotUpdated, object: self)
    }
        
    func addProfile(profile: Profile) -> Void {
        ProfileManager.shared.profiles.append(profile)
    }
    


}
