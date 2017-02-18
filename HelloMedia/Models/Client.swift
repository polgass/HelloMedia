//
//  SessionClient.swift
//  HelloMedia
//
//  Created by Peter Paul Sevilla on 18/02/2017.
//  Copyright © 2017 Peter Paul Sevilla. All rights reserved.
//

import Foundation

typealias SuccessErrorCompletion = (_ success: Bool, _ error: Error?) -> ()
typealias UserErrorCompletion = (_ user: User?, _ error: Error?) -> ()

class Client {
  let service: Service
  
  init(service: Service) {
    self.service = service
  }
  
  func login(completion: @escaping SuccessErrorCompletion) {
    service.login(completion: completion)
  }
  
  func logout(completion: @escaping SuccessErrorCompletion) {
    service.logout(completion: completion)
  }
  
  func getProfile(completion: @escaping UserErrorCompletion) {
    service.getProfile(completion: completion)
  }
}
