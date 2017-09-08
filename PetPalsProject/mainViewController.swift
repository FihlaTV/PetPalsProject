//
//  mainViewController.swift
//  PetPalsProject
//
//  Created by ADENIKE TOMOMEWO on 8/29/17.
//  Copyright © 2017 ADENIKE TOMOMEWO. All rights reserved.
//

import UIKit
import FirebaseAuth

class mainViewController: UIViewController {

    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func loginTapped(_ sender: Any) {
        guard emailTextField.text != "", passwordTextField.text != "" else {return}
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!, completion: { (user, error) in
            if error != nil {
               
                
            }else{
                print("Sign in was Successfull")
                self.performSegue(withIdentifier: "signInSegue", sender: nil)
                
            }
            
            
            
        })

    }
    
    }
