//
//  Message.swift
//  HelloMedia
//
//  Created by Peter Paul Sevilla on 18/02/2017.
//  Copyright © 2017 Peter Paul Sevilla. All rights reserved.
//

import Foundation
import Firebase

struct ChatMessage {
  
  let key: String
  let name: String
  let email: String
  let message: String
  let ref: FIRDatabaseReference?
  
  init(snapshot: FIRDataSnapshot) {
    key = snapshot.key
    let snapshotValue = snapshot.value as! [String: AnyObject]
    name = snapshotValue["name"] as! String
    email = snapshotValue["email"] as! String
    message = snapshotValue["message"] as! String
    ref = snapshot.ref
  }
  
  init(name: String, email: String, message: String, key: String = "") {
    self.key = key
    self.name = name
    self.email = email
    self.message = message
    self.ref = nil
  }
  
  func toAnyObject() -> Any {
    return [
      "name": name,
      "email": email,
      "message": message,
    ]
  }
  
}
