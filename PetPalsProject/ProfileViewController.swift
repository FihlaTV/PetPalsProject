//
//  ProfileViewController.swift
//  PetPalsProject
//
//  Created by ADENIKE TOMOMEWO on 9/17/17.
//  Copyright © 2017 ADENIKE TOMOMEWO. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth
import FirebaseStorage
import SDWebImage


class ProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var refUser: DatabaseReference!
    
    @IBOutlet weak var usernameText: UILabel!
    
    @IBOutlet weak var displayEmail: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var askSitter: UILabel!
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
        
        

    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        loadUserInfo()
    }
    
    func loadUserInfo(){
        
        let userRef = dataBaseRef.child("users/\(Auth.auth().currentUser!.uid)")
        userRef.observe(.value, with: { (snapshot) in
            
            let user = Sitters(snapshot: snapshot)
            
            self.usernameText.text = user.fullname
            self.displayEmail.text = user.email
           
            
            let imageURL = user.urlto!
            
            self.storageRef.reference(forURL: imageURL).getData(maxSize: 10 * 1024 * 1024, completion: { (data, error) in
                if error == nil {
                    if let data = data {
                        DispatchQueue.main.async(execute: {
                            
                            self.profileImage.image = UIImage(data: data)
                        })  }
                    
                    
                    
                }else {
                    
                    let alertView = SCLAlertView()
                    alertView.showError("😁OOPS😁", subTitle: error!.localizedDescription)
                }
            })
            
            
            
            
            
            
            
        }) { (error) in
            
            let alertView = SCLAlertView()
            alertView.showError("😁OOPS😁", subTitle: error.localizedDescription)
        }
        
        
        
        
        
        
    }
    
    

    
    
    
    
    @IBAction func logOutAction(sender: UIBarButtonItem) {
        
        
        do {
                try Auth.auth().signOut()
            if Auth.auth().currentUser == nil {

                
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Login") as! LoginViewController
                present(vc, animated: true, completion: nil)
            }
            } catch let error as NSError {
                
                let alertView = SCLAlertView()
                alertView.showError("😁OOPS😁", subTitle: error.localizedDescription)
            }
        }
        
        
    
    

    
    
    

}


