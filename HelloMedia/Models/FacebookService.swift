//
//  FacebookLogin.swift
//  HelloMedia
//
//  Created by Peter Paul Sevilla on 18/02/2017.
//  Copyright © 2017 Peter Paul Sevilla. All rights reserved.
//

import Foundation
import FacebookLogin
import FacebookCore

class FacebookService: Service {
  
  // MARK:- Properties
  let loginManager = LoginManager()
  let sourceViewController: UIViewController
  
  // MARK:- Initializers
  init(sourceViewController: UIViewController) {
    self.sourceViewController = sourceViewController
  }
  
  // MARK:- Protocol methods
  func login(completion: @escaping (Bool, Error?) -> ()) {
    loginManager.logIn(readPermissions: [.publicProfile, .email], viewController: sourceViewController) { loginResult in
      switch loginResult {
      case .failed(let error):
        completion(false, error)
      case .cancelled:
        completion(false, nil)
      case .success(_, _, _):
        completion(true, nil)
      }
    }
  }
  
  func logout(completion: @escaping (Bool, Error?) -> ()) {
    loginManager.logOut()
    UserDefaults.standard.removeObject(forKey: kCurrentUser)
    completion(true, nil)
  }
  
  func getProfile(completion: @escaping UserErrorCompletion) {
    let connection = GraphRequestConnection()
    connection.add(FacebookProfileRequest()) { response, result in
      switch result {
      case .success(let response):
        completion(response.user, nil)
      case .failed(let error):
        completion(nil, error)
      }
    }
    connection.start()
  }
}
