//
//  User.swift
//  HelloMedia
//
//  Created by Peter Paul Sevilla on 18/02/2017.
//  Copyright © 2017 Peter Paul Sevilla. All rights reserved.
//

import Foundation
import Firebase

/// User profile
class User: NSObject, NSCoding {
  
  var uid: String?
  var firstName: String?
  var lastName: String?
  var email: String?
  var photoUrl: String?
  
  
  /// Initializes a user object from a Firebase instance
  ///
  /// - Parameter authData: A Firebase user object.
  init(authData: FIRUser) {
    uid = authData.uid
    email = authData.email!
    firstName = ""
    lastName = ""
    photoUrl = ""
    
  }
  
  
  /// Initializes a User object
  ///
  /// - Parameters:
  ///   - uid: The user id.
  ///   - firstName: The user's first name.
  ///   - lastName: The user's last name.
  ///   - email: The user's email.
  ///   - photoUrl: The user's profile picture link (string).
  init(uid: String?, firstName: String?,
       lastName: String?, email: String?,
       photoUrl: String?) {
    self.uid = uid
    self.firstName = firstName
    self.lastName = lastName
    self.email = email
    self.photoUrl = photoUrl
  }
  
  
  /// Serializes the data to its correct data type
  ///
  /// - Parameter decoder: The data.
  required init(coder decoder: NSCoder) {
    self.uid = decoder.decodeObject(forKey: "uid") as? String ?? ""
    self.firstName = decoder.decodeObject(forKey: "firstName") as? String ?? ""
    self.lastName = decoder.decodeObject(forKey: "lastName") as? String ?? ""
    self.email = decoder.decodeObject(forKey: "email") as? String ?? ""
    self.photoUrl = decoder.decodeObject(forKey: "photoUrl") as? String ?? ""
  }
  
  
  /// Transforms the property to data
  ///
  /// - Parameter coder: The coder object.
  func encode(with coder: NSCoder) {
    coder.encode(uid, forKey: "uid")
    coder.encode(firstName, forKey: "firstName")
    coder.encode(lastName, forKey: "lastName")
    coder.encode(email, forKey: "email")
    coder.encode(photoUrl, forKey: "photoUrl")
  }
  
}
