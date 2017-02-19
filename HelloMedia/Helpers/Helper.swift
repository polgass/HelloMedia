//
//  Helper.swift
//  HelloMedia
//
//  Created by Peter Paul Sevilla on 18/02/2017.
//  Copyright © 2017 Peter Paul Sevilla. All rights reserved.
//

import Foundation

class Helper {
  
  /// Save a custom object to UserDefaults.
  ///
  /// - Parameters:
  ///   - key: The object's key.
  ///   - object: The object's value.
  class func saveObject(key: String, object: AnyObject) {
    let encodedData = NSKeyedArchiver.archivedData(withRootObject: object)
    UserDefaults.standard.set(encodedData, forKey: key)
  }
  
  
  /// Get a UserDefaults custom object.
  ///
  /// - Parameter key: The object's key.
  /// - Returns: An optional object.
  class func getObject(key: String) -> AnyObject? {
    guard let data = UserDefaults.standard.data(forKey: key),
      let object = NSKeyedUnarchiver.unarchiveObject(with: data) else {
        return nil
    }
    return object as AnyObject?
  }
}
