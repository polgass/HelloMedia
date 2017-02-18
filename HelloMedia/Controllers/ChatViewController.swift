//
//  ChatViewController.swift
//  HelloMedia
//
//  Created by Peter Paul Sevilla on 18/02/2017.
//  Copyright © 2017 Peter Paul Sevilla. All rights reserved.
//

import UIKit
import Firebase

class ChatViewController: UIViewController {
  
  // MARK:- Outlets
  @IBOutlet weak var tableView: UITableView!
  
  // MARK:- Properties
  let ref = FIRDatabase.database().reference(withPath: "chat-messages")
  let alertCellIdentifier = "MessageCellIdentifier"
  var messages: [ChatMessage] = []
  var user: User!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupTableView()
    setupOtherViews()
    
    ref.observe(.value, with: { snapshot in
      var messages: [ChatMessage] = []
      
      for item in snapshot.children {
        let message = ChatMessage(snapshot: item as! FIRDataSnapshot)
        messages.append(message)
      }
      
      messages = messages.sorted(by: {$0.key > $1.key})
      
      self.messages = messages
      self.tableView.reloadData()
    })
  }
  
  // MARK:- Private methods
  private func setupTableView() {
    tableView.register(MessageCell.nib(), forCellReuseIdentifier: alertCellIdentifier)
    tableView.estimatedRowHeight = 50.0
    tableView.rowHeight = UITableViewAutomaticDimension
  }
  
  private func setupOtherViews() {
    navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addTapped))
  }
  
  // MARK:- Internal methods
  func addTapped() {
    let alert = UIAlertController(title: "Chat",
                                  message: "Send a new message",
                                  preferredStyle: .alert)
    
    let sendAction = UIAlertAction(title: "Send",
                                   style: .default) { [weak self] _ in
                                    guard let weakSelf = self else { return }
                                    guard let textField = alert.textFields?.first,
                                      let text = textField.text else { return }
                                    
                                    let message = ChatMessage(name: weakSelf.user.firstName!,
                                                              email: weakSelf.user.email!,
                                                              message: text)
                                  
                                    let ref = weakSelf.ref.child(Date().toString())
                                    ref.setValue(message.toAnyObject())
    }
    
    let cancelAction = UIAlertAction(title: "Cancel",
                                     style: .default)
    
    alert.addTextField()
    alert.addAction(sendAction)
    alert.addAction(cancelAction)
    
    present(alert, animated: true, completion: nil)
  }
}

extension ChatViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return messages.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: alertCellIdentifier, for: indexPath) as! MessageCell
    let row = indexPath.row
    let message = messages[row]
    cell.chat = message
    
    return cell
  }
}