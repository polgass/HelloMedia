//
//  LoginService.swift
//  HelloMedia
//
//  Created by Peter Paul Sevilla on 18/02/2017.
//  Copyright © 2017 Peter Paul Sevilla. All rights reserved.
//

import Foundation

/// Interface for Facebook and Firebase services requests
protocol Service {
  
  /// Login service
  ///
  /// - Parameter completion: The login callback function.
  func login(completion: @escaping SuccessErrorCompletion)
  
  
  /// Logout service
  ///
  /// - Parameter completion: The logout callback function.
  func logout(completion: @escaping SuccessErrorCompletion)
  
  
  /// Get user profile service
  ///
  /// - Parameter completion: A callback function to handle the user object.
  func getProfile(completion: @escaping UserErrorCompletion)
}
