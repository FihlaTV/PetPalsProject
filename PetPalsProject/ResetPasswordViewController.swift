//
//  ResetPasswordViewController.swift
//  PetPalsProject
//
//  Created by ADENIKE TOMOMEWO on 11/14/17.
//  Copyright © 2017 ADENIKE TOMOMEWO. All rights reserved.
//

import UIKit

class ResetPasswordViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var emailTextfield: UITextField!
    
    @IBOutlet weak var resetView: UIView!
    
    @IBOutlet weak var resetButton: UIButton!
 var authService = AuthenticationService()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        emailTextfield.delegate = self
        resetView.layer.cornerRadius = 10.0
        resetView.clipsToBounds = true
        resetButton.layer.cornerRadius = 10.0
        resetButton.clipsToBounds = true
        // Creating Tap Gesture to dismiss Keyboard
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(SignUpViewController.dismissKeyboard(gesture:)))
        tapGesture.numberOfTapsRequired = 1
        view.addGestureRecognizer(tapGesture)
        
        // Creating Swipe Gesture to dismiss Keyboard
        let swipDown = UISwipeGestureRecognizer(target: self, action: #selector(SignUpViewController.dismissKeyboard(gesture:)))
        swipDown.direction = .down
        view.addGestureRecognizer(swipDown)
    }
    // Dismissing the Keyboard with the Return Keyboard Button
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        emailTextfield.resignFirstResponder()
        return true
    }
    
    @IBAction func resetAction(_ sender: Any) {
        let email = emailTextfield.text!.lowercased()
        let finalEmail = email.trimmingCharacters(in: NSCharacterSet.whitespaces)
        
        if finalEmail.isEmpty {
            self.view.endEditing(true)
            let alertView = SCLAlertView()
            alertView.showError("😁OOPS😁", subTitle: "You need to provide a valid email address in order to reset your password. Please do it and try again later.")
        }else {
            self.view.endEditing(true)
            
            authService.resetPassword(email: finalEmail)
        }
    }
    
    
    // Dismissing all editing actions when User Tap or Swipe down on the Main View
    func dismissKeyboard(gesture: UIGestureRecognizer){
        self.view.endEditing(true)
    }
    
    // Moving the View up after the Keyboard appears
    func textFieldDidBeginEditing(_ textField: UITextField) {
        animateView(up: true, moveValue: 80)
    }
    
    // Moving the View up after the Keyboard disappears
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
    
    @IBAction func dismissTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    

}
