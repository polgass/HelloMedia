//
//  Extensions.swift
//  HelloMedia
//
//  Created by Peter Paul Sevilla on 18/02/2017.
//  Copyright © 2017 Peter Paul Sevilla. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
  func imageForURLString(_ string: String) {
    if let url = URL(string: string) {
      DispatchQueue.global().async { [weak self] in
        guard let weakSelf = self else { return }
        let data = try? Data(contentsOf: url)
        DispatchQueue.main.async {
          weakSelf.image = UIImage(data: data!)
        }
      }
    }
  }
}
