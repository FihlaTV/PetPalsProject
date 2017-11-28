//
//  SittersViewController.swift
//  PetPalsProject
//
//  Created by ADENIKE TOMOMEWO on 11/19/17.
//  Copyright © 2017 ADENIKE TOMOMEWO. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth
import FirebaseStorage
import SDWebImage

class SittersViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var usernameText: UILabel!
    
    @IBOutlet weak var displayEmail: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var userNumber: UILabel!
   
    var ref: DatabaseReference!
    var handle: DatabaseHandle!
    var users: Sitters!
    var imagePicker = UIImagePickerController()
    var dataBaseRef: DatabaseReference! {
        
        return Database.database().reference()
    }
    
    var storageRef: Storage! {
        
        return Storage.storage()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileImage.layer.cornerRadius = profileImage.layer.frame.height/2
        
        imagePicker.delegate = self
        ref = Database.database().reference()
        let userID = Auth.auth().currentUser?.uid
        ref.child("users").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSDictionary
            let username = value?["fullname"] as? String ?? ""
            //  let user = Users.init(username: username)
            let email = value?["email"] as? String
            let userPhone = value?["phoneNumber"] as? String
            self.usernameText.text = username
            self.displayEmail.text = email
            self.userNumber.text = userPhone
            
            
            
            if let m = value?["urlToImage"] as? String{
                
                self.profileImage.sd_setImage(with: URL(string: m), completed: nil)
            }
        })
        
        
    }
    
    
    
    


    
}
