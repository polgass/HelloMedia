//
//  MessageCell.swift
//  HelloMedia
//
//  Created by Peter Paul Sevilla on 18/02/2017.
//  Copyright © 2017 Peter Paul Sevilla. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {
  
  // MARK:- Outlets
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var emailLabel: UILabel!
  @IBOutlet weak var messageLabel: UILabel!
  
  // MARK:- Properties
  var chat: ChatMessage! {
    didSet {
      configureCell()
    }
  }
  
  // MARK:- Public methods
  class func nib() -> UINib {
    return UINib(nibName: NSStringFromClass(self).components(separatedBy: ".").last!, bundle: nil)
  }
  
  // MARK:- Private methods
  private func configureCell() {
    nameLabel.text = chat.name
    emailLabel.text = chat.email
    messageLabel.text = chat.message
  }
  
}
