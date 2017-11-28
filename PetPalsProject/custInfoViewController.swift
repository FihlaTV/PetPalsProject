//
//  custInfoViewController.swift
//  PetPalsProject
//
//  Created by ADENIKE TOMOMEWO on 11/3/17.
//  Copyright © 2017 ADENIKE TOMOMEWO. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth
import FirebaseStorage

class custInfoViewController: UIViewController{

    @IBOutlet weak var userImageView: UIImageView!
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    
    @IBOutlet weak var userBiography: UILabel!
    var user: Users!
    override func viewDidLoad() {
        super.viewDidLoad()
        userImageView.layer.cornerRadius = userImageView.layer.frame.width/2

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        let userRef = Database.database().reference().child("users").queryOrdered(byChild: "uid").queryEqual(toValue: Auth.auth().currentUser?.uid)
        
        userRef.observe(.value, with: { (snapshot) in
            for UserInfo in snapshot.children.allObjects as! [DataSnapshot] {
                let user = UserInfo.value as? [String: AnyObject]
            
            
            if let user = self.user {
                self.usernameLabel.text = user.fullname
                self.userBiography.text = user.email
                
                Storage.storage().reference(forURL: user.urlto!).getData(maxSize: 1 * 1024 * 1024, completion: { (imgData, error) in
                    if let error = error {
                        let alertView = UIAlertController(title: error.localizedDescription, message: "OOPS", preferredStyle: .alert)
                    }else{
                        DispatchQueue.main.async(execute:  {
                            if let data = imgData {
                                self.userImageView.image = UIImage(data: data)
                            }
                        })
                    }
                })
                
            }
        }
    })
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
}
