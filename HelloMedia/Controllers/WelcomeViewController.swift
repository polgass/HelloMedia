//
//  WelcomeViewController.swift
//  HelloMedia
//
//  Created by Peter Paul Sevilla on 18/02/2017.
//  Copyright © 2017 Peter Paul Sevilla. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {
  
  // MARK:- Outlets
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var emailLabel: UILabel!
  
  // MARK:- Properties
  var user: User!
  
  // MARK:- Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    displayData()
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == kWelcomeToChat,
      let chatVC = segue.destination as? ChatViewController {
      chatVC.user = user
    }
  }
  
  // MARK:- Private methods
  func displayData() {
    // name
    var name = String()
    if let firstName = user.firstName {
      name = "\(firstName) "
    }
    
    if let lastName = user.lastName {
      name += "\(lastName)"
    }
    
    // email
    var email = String()
    if let mail = user.email {
      email = mail
    }
   
    // photo
    if let pic = user.photoUrl {
      imageView.imageForURLString(pic)
    }
    
    nameLabel.text = name
    emailLabel.text = email
  }
  
  //MARK:- Actions
  @IBAction func logoutTapped(_ sender: Any) {
    let client = Client(service: FacebookService(sourceViewController: self))
    
    client.logout { [weak self] (success, error) in
      guard let weakSelf = self else { return }
      
      if success {
        weakSelf.dismiss(animated: true, completion: nil)
      }
    }
  }
  
  @IBAction func chatTapped(_ sender: Any) {
    performSegue(withIdentifier: kWelcomeToChat, sender: nil)
  }
  
}
