//
//  FacebookLogin.swift
//  HelloMedia
//
//  Created by Peter Paul Sevilla on 18/02/2017.
//  Copyright © 2017 Peter Paul Sevilla. All rights reserved.
//

import Foundation
import FacebookLogin

class FacebookSessionService: SessionService {
  
  // MARK:- Properties
  let sourceViewController: UIViewController
  
  // MARK:- Initializers
  init(sourceViewController: UIViewController) {
    self.sourceViewController = sourceViewController
  }
  
  // MARK:- Public methods
  func login(completion: @escaping (Bool, Error?) -> ()) {
    let loginManager = LoginManager()
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
    
  }
}
