//
//  petReviewViewController.swift
//  PetPalsProject
//
//  Created by ADENIKE TOMOMEWO on 8/29/17.
//  Copyright © 2017 ADENIKE TOMOMEWO. All rights reserved.
//

import UIKit
import FirebaseDatabase
class petReviewViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var descripLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    var users: [Users] = []

    var ref: DatabaseReference!
    var handle: DatabaseHandle!
    override func viewDidLoad() {
        super.viewDidLoad()
    /*
       let user = Users()
        
        ref = Database.database().reference()
        handle = ref?.child("users").observe(DataEventType.childAdded, with: { (snapshot) in
            
            print(snapshot)
            if let name = (snapshot.value as! NSDictionary) ["email"] as? String {
          user.email = name
    
    }
            let username = (snapshot.value as! NSDictionary) ["fullname"] as? String
           
            self.nameLabel.text = username
            self.users.append(user)
           
            self.tableView.reloadData()
            self.tableView.dataSource = self
            self.tableView.delegate = self
        })*/
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return users.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let user = users[indexPath.row]
        cell.textLabel?.text = user.email
        
        return cell
    }
}
