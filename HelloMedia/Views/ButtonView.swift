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
  
  private let kFont = "HelveticaNeue"
  private let kFontSize: CGFloat = 15.0
  private let kButtonCornerRadius: CGFloat = 5.0
  private let kMultiplier: CGFloat = 1.60
  
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
    button.titleLabel?.font = UIFont(name: kFont, size: kFontSize)
    
    button.layer.cornerRadius = kButtonCornerRadius
    button.layer.borderWidth = kCGFloatOne
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
    NSLayoutConstraint(item: button, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: kCGFloatOne, constant: kCGFloatZero).isActive = true
    NSLayoutConstraint(item: button, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: kCGFloatOne, constant: kCGFloatZero).isActive = true
    NSLayoutConstraint(item: button, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: kCGFloatOne, constant: kCGFloatZero).isActive = true
    NSLayoutConstraint(item: button, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: kCGFloatOne, constant: kCGFloatZero).isActive = true
    
    // activity indicator
    NSLayoutConstraint(item: activityIndicator, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: kCGFloatOne, constant: kCGFloatZero).isActive = true
    NSLayoutConstraint(item: activityIndicator, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: kMultiplier, constant: kCGFloatZero).isActive = true
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
  
  // MARK:- Selectors
  @objc func buttonTapped(button: UIButton) {
    if let delegate = delegate {
      delegate.submit()
    }
  }
}
