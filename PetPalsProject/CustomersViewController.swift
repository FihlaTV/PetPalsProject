//
//  CustomersViewController.swift
//  PetPalsProject
//
//  Created by ADENIKE TOMOMEWO on 9/7/17.
//  Copyright © 2017 ADENIKE TOMOMEWO. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class CustomersViewController: UIViewController{

    @IBOutlet weak var usernameText: UILabel!
    
    @IBOutlet weak var profileImageText: UIImageView!
    
    @IBOutlet weak var displayNameText: UILabel!
    var databaseRef: DatabaseReference!
  
    override func viewDidLoad() {
        super.viewDidLoad()
        databaseRef = Database.database().reference()
        
        if let userID = Auth.auth().currentUser?.uid {
            databaseRef.child("users").child(userID).observeSingleEvent(of:.childAdded, with: {(snapshot) in
                let dictionary = snapshot.value as? NSDictionary
                let username = dictionary?["full name"] as? String ?? "full name"
                if let profileImageURL = dictionary?["urlToImage"] as? String{
                    let url = URL(string: profileImageURL)
                    
                    URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
                        if error != nil{
                            print(error!)
                            return
                        }
                        DispatchQueue.main.async {
                            self.profileImageText.image = UIImage(data: data!)
                        }
                    }) .resume()
                }
                self.usernameText.text = username
                self.displayNameText.text = username
            }) { (error) in
                print(error.localizedDescription)
                return
            }
        }
        

    }
    
    
   }
