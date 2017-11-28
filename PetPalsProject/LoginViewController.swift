//
//  LoginViewController.swift
//  PetPalsProject
//
//  Created by ADENIKE TOMOMEWO on 11/14/17.
//  Copyright © 2017 ADENIKE TOMOMEWO. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var usernameTextfield: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!

    @IBOutlet weak var Loginview: UIView!
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var signupButton: UIButton!
    var authService = AuthenticationService()
    var cornerRadius: CGFloat = 0
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        usernameTextfield.delegate = self
        passwordTextField.delegate = self
        Loginview.layer.cornerRadius = 10.0
        Loginview.clipsToBounds = true
        loginButton.layer.cornerRadius = 10.0
        loginButton.clipsToBounds = true
        signupButton.layer.cornerRadius = 10.0
        signupButton.clipsToBounds = true
        
       
        
        // Creating Tap Gesture to dismiss Keyboard
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(LoginViewController.dismissKeyboard(gesture:)))
        tapGesture.numberOfTapsRequired = 1
        view.addGestureRecognizer(tapGesture)
        
        // Creating Swipe Gesture to dismiss Keyboard
        let swipDown = UISwipeGestureRecognizer(target: self, action: #selector(LoginViewController.dismissKeyboard(gesture:)))
        swipDown.direction = .down
        view.addGestureRecognizer(swipDown)
        
        view.bringSubview(toFront: Loginview)
        
    }
    
    // Unwind Segue Action
    @IBAction func unwindToLogin(storyboard: UIStoryboardSegue){}
    
    
    // Dismissing the Keyboard with the Return Keyboard Button
    func dismissKeyboard(gesture: UIGestureRecognizer){
        self.view.endEditing(true)
    }
    
    // Dismissing the Keyboard with the Return Keyboard Button
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        usernameTextfield.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        return true
    }
    
    // Moving the View down after the Keyboard appears
    func textFieldDidBeginEditing(_ textField: UITextField) {
        animateView(up: true, moveValue: 80)
    }
    
    // Moving the View down after the Keyboard disappears
    func textFieldDidEndEditing(_ textField: UITextField) {
        animateView(up: false, moveValue: 80)
    }
    
    
    // Move the View Up & Down when the Keyboard appears
    func animateView(up: Bool, moveValue: CGFloat){
        
        let movementDuration: TimeInterval = 0.3
        let movement: CGFloat = (up ? -moveValue : moveValue)
        UIView.beginAnimations("animateView", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(movementDuration)
        self.view.frame = self.view.frame.offsetBy(dx: 0, dy: movement)
        UIView.commitAnimations()
        
        
    }
    
    
    @IBAction func LoginTapped(_ sender: Any) {
        let email = usernameTextfield.text!.lowercased()
        let finalEmail = email.trimmingCharacters(in: NSCharacterSet.whitespaces)
        let password = passwordTextField.text!
        
        if finalEmail.isEmpty || password.isEmpty {
            self.view.endEditing(true)
            
            let alertView = SCLAlertView()
            alertView.showError("😁OOPS😁", subTitle: "it seems like one of the Fields is empty. Please fill all the Fields and Try Again later.")
            
        }else {
            self.view.endEditing(true)
            authService.signIn(email: finalEmail, password: password)
            
        }
        
    
    }

    }
