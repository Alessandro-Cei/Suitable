//
//  Profile.swift
//  Suitable
//
//  Created by Ale on 19/01/23.
//

//TODO: - Temporary profile model, just to get rid of the errors
import Foundation
import UIKit

struct ProfileVecchio: Identifiable, Equatable, Codable {
  var id = UUID()
  let displayName: String
  let body: String
  var time = Date()

  var isUser: Bool {
    return displayName == UIDevice.current.name
  }
}

import Foundation
import SwiftUI

struct Profile: Identifiable {
    
    var id = UUID()
    var name : String
    var surname : String
    var birthDate : String
    var image : String
    var description : String
    var tags : [String]
    var links : [URL]
    var backgroundColor : [Color]
}
