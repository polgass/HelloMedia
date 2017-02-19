//
//  FirebaseService.swift
//  HelloMedia
//
//  Created by Peter Paul Sevilla on 19/02/2017.
//  Copyright © 2017 Peter Paul Sevilla. All rights reserved.
//

import Foundation
import Firebase
import FacebookCore

class FirebaseService: Service {
  
  /// Handles Firebase login
  ///
  /// - Parameter completion: The login callback function.
  func login(completion: @escaping SuccessErrorCompletion) {}
  
  
  /// Handles Fibrebase logout
  ///
  /// - Parameter completion: The logout callback function.
  func logout(completion: @escaping SuccessErrorCompletion) {}
  
  
  /// Handles Firebase profile fetch (with login)
  ///
  /// - Parameter completion: A callback function to handle user object.
  func getProfile(completion: @escaping UserErrorCompletion) {
    let credential = FIRFacebookAuthProvider.credential(withAccessToken: AccessToken.current!.authenticationToken)
    FIRAuth.auth()?.signIn(with: credential) { (user, error) in
      if error == nil {
        let currentUser = User(authData: user!)
        completion(currentUser, nil)
      } else {
        completion(nil, error)
      }
    }
  }
}
