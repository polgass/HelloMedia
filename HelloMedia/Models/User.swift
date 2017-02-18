//
//  User.swift
//  HelloMedia
//
//  Created by Peter Paul Sevilla on 18/02/2017.
//  Copyright © 2017 Peter Paul Sevilla. All rights reserved.
//

import Foundation
import Firebase

class User: NSObject, NSCoding {
  
  let uid: String?
  let firstName: String?
  let lastName: String?
  let email: String?
  let photoUrl: String?
  
  init(authData: FIRUser) {
    uid = authData.uid
    email = authData.email!
    firstName = ""
    lastName = ""
    photoUrl = ""
    
  }
  
  init(uid: String?, firstName: String?,
       lastName: String?, email: String?,
       photoUrl: String?) {
    self.uid = uid
    self.firstName = firstName
    self.lastName = lastName
    self.email = email
    self.photoUrl = photoUrl
  }
  
  required init(coder decoder: NSCoder) {
    self.uid = decoder.decodeObject(forKey: "uid") as? String ?? ""
    self.firstName = decoder.decodeObject(forKey: "firstName") as? String ?? ""
    self.lastName = decoder.decodeObject(forKey: "lastName") as? String ?? ""
    self.email = decoder.decodeObject(forKey: "email") as? String ?? ""
    self.photoUrl = decoder.decodeObject(forKey: "photoUrl") as? String ?? ""
  }
  
  func encode(with coder: NSCoder) {
    coder.encode(uid, forKey: "uid")
    coder.encode(firstName, forKey: "firstName")
    coder.encode(lastName, forKey: "lastName")
    coder.encode(email, forKey: "email")
    coder.encode(photoUrl, forKey: "photoUrl")
  }
  
}
