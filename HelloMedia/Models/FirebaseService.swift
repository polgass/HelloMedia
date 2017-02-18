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
  func login(completion: @escaping SuccessErrorCompletion) {}
  
  func logout(completion: @escaping SuccessErrorCompletion) {}
  
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
