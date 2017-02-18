//
//  FacebookProfileRequest.swift
//  HelloMedia
//
//  Created by Peter Paul Sevilla on 18/02/2017.
//  Copyright © 2017 Peter Paul Sevilla. All rights reserved.
//

import Foundation
import FacebookCore

struct FacebookProfileRequest: GraphRequestProtocol {
  // MARK:- Properties
  var graphPath = "/me"
  var parameters: [String : Any]? = ["fields": "first_name, last_name, email, picture.type(large)"]
  var accessToken = AccessToken.current
  var httpMethod: GraphRequestHTTPMethod = .GET
  var apiVersion: GraphAPIVersion = .defaultVersion
  
  struct Response: GraphResponseProtocol {
    var user: User?
    
    init(rawResponse: Any?) {
      if let response = rawResponse,
        let dict = response as? [String: AnyObject] {
        let firstName = dict["first_name"] as? String
        let lastName = dict["last_name"] as? String
        let email = dict["email"] as? String
        
        var photoUrl: String!
        if let picture = dict["picture"] as? [String: AnyObject],
          let data = picture["data"] as? [String: AnyObject],
          let url = data["url"] as? String {
          photoUrl = url
        }
        
        user = User(uid: nil,
                    firstName: firstName,
                    lastName: lastName,
                    email: email,
                    photoUrl: photoUrl)
        
      }
    }
  }
}
