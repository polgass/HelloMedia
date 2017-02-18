//
//  SessionClient.swift
//  HelloMedia
//
//  Created by Peter Paul Sevilla on 18/02/2017.
//  Copyright © 2017 Peter Paul Sevilla. All rights reserved.
//

import Foundation

typealias SuccessErrorCompletion = (_ success: Bool, _ error: Error?) -> ()

class SessionClient {
  let service: SessionService
  
  init(service: SessionService) {
    self.service = service
  }
  
  func login(completion: @escaping SuccessErrorCompletion) {
    service.login(completion: completion)
  }
  
  func logout(completion: @escaping SuccessErrorCompletion) {
    
  }
}
