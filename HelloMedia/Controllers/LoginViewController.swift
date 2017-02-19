//
//  LoginViewController.swift
//  HelloMedia
//
//  Created by Peter Paul Sevilla on 18/02/2017.
//  Copyright © 2017 Peter Paul Sevilla. All rights reserved.
//

import UIKit
import FacebookCore

class LoginViewController: UIViewController {
  
  // MARK: Outlets
  @IBOutlet weak var buttonView: ButtonView!
  @IBOutlet weak var messageLabel: UILabel!
  
  // MARK:- Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    configureViews()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    if let _ = AccessToken.current {
      if let currentUser = Helper.getObject(key: kCurrentUser) as? User {
        performSegue(withIdentifier: kLoginToWelcome, sender: currentUser)
      }
    }
  }
  
  // MARK:- Overrides
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == kLoginToWelcome,
      let navigationController = segue.destination as? UINavigationController,
      let welcomeVC = navigationController.viewControllers.first as? WelcomeViewController,
      let user = sender as? User {
      welcomeVC.user = user
    }
  }
  
  // MARK:- Private methods
  private func configureViews() {
    buttonView.buttonTitle = kLogin
    buttonView.delegate = self
  }
  
  // MARK:- Internal methods
  func firebaseSync() {
    let firClient = Client(service: FirebaseService())
    
    firClient.getProfile { [weak self] (user, error) in
      
      guard let weakSelf = self, let user = user else { return }
      let uid = user.uid
      
      let fbClient = Client(service: FacebookService(sourceViewController: weakSelf))
      
      fbClient.getProfile { [weak self] (user, error) in
        guard let weakSelf = self else { return }
        guard let user = user else { return }
        
        user.uid = uid
        Helper.saveObject(key: kCurrentUser, object: user)
        
        weakSelf.buttonView.startActivity = false
        weakSelf.performSegue(withIdentifier: kLoginToWelcome, sender: user)
      }
    }
  }
}

// MARK:- ButtonViewDelegate methods
extension LoginViewController: ButtonViewDelegate {
  func submit() {
    buttonView.startActivity = true
    messageLabel.isHidden = true
    
    let client = Client(service: FacebookService(sourceViewController: self))
    
    client.login { [weak self] (success, error) in
      guard let weakSelf = self else { return }
      
      weakSelf.messageLabel.isHidden = success
      
      if success {
        if AccessToken.current != nil {
          weakSelf.firebaseSync()
        }
      } else {
        weakSelf.buttonView.startActivity = false
      }
    }
  }
}
