//
//  Message.swift
//  HelloMedia
//
//  Created by Peter Paul Sevilla on 18/02/2017.
//  Copyright © 2017 Peter Paul Sevilla. All rights reserved.
//

import Foundation
import Firebase


/// Wrapper for chat messages
struct ChatMessage {
  
  let key: String
  let name: String
  let email: String
  let message: String
  let ref: FIRDatabaseReference?
  
  
  /// Initializes a ChatMessage object from a Firebase snapshot
  ///
  /// - Parameter snapshot: The snapshot.
  init(snapshot: FIRDataSnapshot) {
    key = snapshot.key
    let snapshotValue = snapshot.value as! [String: AnyObject]
    name = snapshotValue["name"] as! String
    email = snapshotValue["email"] as! String
    message = snapshotValue["message"] as! String
    ref = snapshot.ref
  }
  
  
  /// Initialized a ChatMessage object
  ///
  /// - Parameters:
  ///   - name: The user's name.
  ///   - email: The user's email.
  ///   - message: The chat message.
  ///   - key: The message key.
  init(name: String, email: String, message: String, key: String = "") {
    self.key = key
    self.name = name
    self.email = email
    self.message = message
    self.ref = nil
  }
  
  
  /// Converts a ChatMessage object to JSON
  ///
  /// - Returns: A JSON object.
  func toAnyObject() -> Any {
    return [
      "name": name,
      "email": email,
      "message": message,
    ]
  }
  
}
