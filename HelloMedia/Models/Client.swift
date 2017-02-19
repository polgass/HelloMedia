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


/// Used for calling Facebook and Firebase services 
/// by implementing dependency injection.
class Client {
  let service: Service
  
  
  /// The service initializer
  ///
  /// - Parameter service: An object that conforms to Service protocol.
  init(service: Service) {
    self.service = service
  }
  
  
  /// The login service method
  ///
  /// - Parameter completion: A callback function after logging in.
  func login(completion: @escaping SuccessErrorCompletion) {
    service.login(completion: completion)
  }
  
  
  /// The logout service method
  ///
  /// - Parameter completion: A callback function after logging out.
  func logout(completion: @escaping SuccessErrorCompletion) {
    service.logout(completion: completion)
  }
  
  
  /// Get user profile service
  ///
  /// - Parameter completion: A callback function after retrieving the user object.
  func getProfile(completion: @escaping UserErrorCompletion) {
    service.getProfile(completion: completion)
  }
}
