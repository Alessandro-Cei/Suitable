//
//  Profile.swift
//  Suitable
//
//  Created by Ale on 19/01/23.
//

//TODO: - Temporary profile model, just to get rid of the errors
import Foundation
import UIKit

//struct ProfileVecchio: Identifiable, Equatable, Codable {
//  var id = UUID()
//  let displayName: String
//  let body: String
//  var time = Date()
//
//  var isUser: Bool {
//    return displayName == UIDevice.current.name
//  }
//}

struct Profile: Identifiable, Equatable, Codable {
    
    var id = UUID()
    var name : String
    var surname : String
    var birthDate : Date
    var image : String?
    var description : String
    var tags : [String]?
    var links : [URL]?
    
//    var backgroundColor : [Color]
    
    let displayName: String
    var isUser: Bool {
      return displayName == UIDevice.current.name
    }

}
