//
//  Helper.swift
//  HelloMedia
//
//  Created by Peter Paul Sevilla on 18/02/2017.
//  Copyright © 2017 Peter Paul Sevilla. All rights reserved.
//

import Foundation

class Helper {
  
  class func saveObject(key: String, object: AnyObject) {
    let encodedData = NSKeyedArchiver.archivedData(withRootObject: object)
    UserDefaults.standard.set(encodedData, forKey: key)
  }
  
  class func getObject(key: String) -> AnyObject? {
    guard let data = UserDefaults.standard.data(forKey: key),
      let object = NSKeyedUnarchiver.unarchiveObject(with: data) else {
        return nil
    }
    return object as AnyObject?
  }
}
