//
//  Profile.swift
//  Suitable
//
//  Created by Ale on 19/01/23.
//

//TODO: - Temporary profile model, just to get rid of the errors
import Foundation
import UIKit

struct Profile: Identifiable, Equatable, Codable {
  var id = UUID()
  let displayName: String
  let body: String
  var time = Date()

  var isUser: Bool {
    return displayName == UIDevice.current.name
  }
}
