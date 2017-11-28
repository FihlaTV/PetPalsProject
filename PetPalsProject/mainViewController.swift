//
//  mainViewController.swift
//  PetPalsProject
//
//  Created by ADENIKE TOMOMEWO on 8/29/17.
//  Copyright © 2017 ADENIKE TOMOMEWO. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase

class mainViewController: UIViewController {

    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    var userStorage: StorageReference!
    var ref: DatabaseReference!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func loginTapped(_ sender: Any) {
        guard emailTextField.text != "", passwordTextField.text != "" else {return}
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!, completion: { (user, error) in
            if error != nil {
                print("Hey we have an error")
                
                          }else {
                print("password does not match")
            }
            
        })
    }
}




    
