//
//  LoginService.swift
//  HelloMedia
//
//  Created by Peter Paul Sevilla on 18/02/2017.
//  Copyright © 2017 Peter Paul Sevilla. All rights reserved.
//

import Foundation

protocol SessionService {
  func login(completion: @escaping SuccessErrorCompletion)
  func logout(completion: @escaping SuccessErrorCompletion)
}
