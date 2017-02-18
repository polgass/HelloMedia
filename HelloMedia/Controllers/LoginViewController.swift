//
//  LoginViewController.swift
//  HelloMedia
//
//  Created by Peter Paul Sevilla on 18/02/2017.
//  Copyright © 2017 Peter Paul Sevilla. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
  
  // MARK: Outlets
  @IBOutlet weak var buttonView: ButtonView!
  
  // MARK:- Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureViews()
  }
  
  // MARK:- Private methods
  private func configureViews() {
    buttonView.buttonTitle = "LOGIN"
    buttonView.delegate = self
  }
  
}

// MARK:- ButtonViewDelegate methods
extension LoginViewController: ButtonViewDelegate {
  func submit() {
    buttonView.startActivity = true
    
    // FIXME:- check if login or logout
    let service = FacebookSessionService(sourceViewController: self)
    let client = SessionClient(service: service)
    
    client.login { [unowned self] (success, error) in
      self.buttonView.startActivity = false
      
      if success {
        self.performSegue(withIdentifier: "LoginToWelcomeScreenSegue", sender: nil)
      }
    }
  }
}
