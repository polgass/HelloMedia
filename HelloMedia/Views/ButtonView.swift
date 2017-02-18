//
//  ButtonView.swift
//  HelloMedia
//
//  Created by Peter Paul Sevilla on 18/02/2017.
//  Copyright © 2017 Peter Paul Sevilla. All rights reserved.
//

import UIKit

protocol ButtonViewDelegate {
  func submit()
}

class ButtonView: UIView {
  
  // MARK:- Properties
  var buttonTitle = String() {
    didSet {
      updateTitle()
    }
  }
  
  var delegate: ButtonViewDelegate!
  
  private var button: UIButton!
  private var activityIndicator: UIActivityIndicatorView!
  
  var startActivity = false {
    didSet {
      start()
    }
  }
  
  // MARK:- Initializers
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    initializeButton()
  }
  
  // MARK:- Private methods
  private func initializeButton() {
    // button
    button = UIButton()
    button.setTitleColor(UIColor.black, for: .normal)
    button.titleLabel?.font = UIFont(name: "HelveticaNeue", size: 15)
    
    button.layer.cornerRadius = 5.0
    button.layer.borderWidth = 1.0
    button.layer.borderColor = UIColor.lightGray.cgColor
    
    button.translatesAutoresizingMaskIntoConstraints = false
    button.addTarget(self, action: #selector(buttonTapped), for: .touchDown)
    addSubview(button)
    
    // activity indicator
    activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    activityIndicator.hidesWhenStopped = true
    
    activityIndicator.translatesAutoresizingMaskIntoConstraints = false
    addSubview(activityIndicator)
    
    // constraints
    // button
    NSLayoutConstraint(item: button, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 0.0).isActive = true
    NSLayoutConstraint(item: button, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: 0.0).isActive = true
    NSLayoutConstraint(item: button, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 0.0).isActive = true
    NSLayoutConstraint(item: button, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: 0.0).isActive = true
    
    // activity indicator
    NSLayoutConstraint(item: activityIndicator, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1.0, constant: 0.0).isActive = true
    NSLayoutConstraint(item: activityIndicator, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.60, constant: 0.0).isActive = true
  }
  
  private func start() {
    button.isEnabled = !startActivity
    if startActivity {
      activityIndicator.startAnimating()
    } else {
      activityIndicator.stopAnimating()
    }
  }
  
  private func updateTitle() {
    button.setTitle(buttonTitle, for: .normal)
  }
  
  // MARK:- Button target methods
  @objc func buttonTapped(button: UIButton) {
    if let delegate = delegate {
      delegate.submit()
    }
  }
}
