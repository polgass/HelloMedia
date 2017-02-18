//
//  LoginViewController.swift
//  HelloMedia
//
//  Created by Peter Paul Sevilla on 18/02/2017.
//  Copyright © 2017 Peter Paul Sevilla. All rights reserved.
//

import UIKit
import FacebookCore
import FacebookLogin

class LoginViewController: UIViewController {
  
  // MARK: Outlets
  @IBOutlet weak var buttonView: ButtonView!
  
  // MARK:- Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    configureViews()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    if let _ = AccessToken.current {
      if let currentUser = Helper.getObject(key: "currentUser") as? User {
        print("perform segue")
        performSegue(withIdentifier: "LoginToWelcomeScreenSegue", sender: currentUser)
      }
    }
  }
  
  // MARK:- Overrides
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "LoginToWelcomeScreenSegue",
      let navigationController = segue.destination as? UINavigationController,
      let welcomeVC = navigationController.viewControllers.first as? WelcomeViewController,
      let user = sender as? User {
      welcomeVC.user = user
    }
  }
  
  // MARK:- Private methods
  private func configureViews() {
    buttonView.buttonTitle = "LOGIN"
    buttonView.delegate = self
  }
  
  // MARK:- Internal methods
  func fetchUserData() {
    let client = SessionClient(service: FacebookSessionService(sourceViewController: self))
    client.getProfile { [weak self] (user, error) in
      guard let weakSelf = self else { return }
      guard let user = user else { return }
      
      Helper.saveObject(key: "currentUser", object: user)
      weakSelf.performSegue(withIdentifier: "LoginToWelcomeScreenSegue", sender: user)
    }
  }
}

// MARK:- ButtonViewDelegate methods
extension LoginViewController: ButtonViewDelegate {
  func submit() {
    buttonView.startActivity = true
    
    // FIXME:- check if login or logout
    let service = FacebookSessionService(sourceViewController: self)
    let client = SessionClient(service: service)
    
    client.login { [weak self] (success, error) in
      guard let weakSelf = self else { return }
      weakSelf.buttonView.startActivity = false
      
      if success {
        weakSelf.fetchUserData()
      }
    }
  }
}
