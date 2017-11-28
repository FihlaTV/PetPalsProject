//
//  SignUpViewController.swift
//  PetPalsProject
//
//  Created by ADENIKE TOMOMEWO on 11/14/17.
//  Copyright © 2017 ADENIKE TOMOMEWO. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController, UITextFieldDelegate,UIPickerViewDelegate, UIPickerViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    @IBOutlet weak var fullnametextField: UITextField!
    
    @IBOutlet weak var emailTextfield: UITextField!
    
    @IBOutlet weak var streetTextField: UITextField!
    
    @IBOutlet weak var cityTextfield: UITextField!
    
    @IBOutlet weak var stateTextfield: UITextField!
    
    @IBOutlet weak var zipcodeTextfield: UITextField!
    
    @IBOutlet weak var phoneTextfield: UITextField!
    
    @IBOutlet weak var passwordTextfield: UITextField!
    
    @IBOutlet weak var userImageView: UIImageView!
    
    @IBOutlet var signUpView: UIView!
    
    @IBOutlet weak var signupButton: UIButton!
    
    @IBOutlet weak var textBox: UITextField!
   
    @IBOutlet weak var dropDown: UIPickerView!
    
    @IBOutlet weak var arrowImagepick: UIImageView!
    
    @IBOutlet weak var outputText: UILabel!
    
    var pickerView: UIPickerView!
    var countryArrays = [String]()
    var authService = AuthenticationService()
    //var stateArrays = [String]()
    //create the list
    var list = ["YES", "NO"]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        fullnametextField.delegate = self
        passwordTextfield.delegate = self
        emailTextfield.delegate = self
        cityTextfield.delegate = self
        streetTextField.delegate = self
        stateTextfield.delegate = self
        zipcodeTextfield.delegate = self
        phoneTextfield.delegate = self
        textBox.delegate = self
        userImageView.layer.cornerRadius = userImageView.layer.frame.width/2
        // Retrieving all the countries, Sorting and Storing them inside countryArrays
        pickerView = UIPickerView()
        pickerView.delegate = self 
        pickerView.dataSource = self
        pickerView.backgroundColor = UIColor.black
        //countryTextField.inputView = pickerView
        signUpView.layer.cornerRadius = 10.0
        signUpView.clipsToBounds = true
        signupButton.layer.cornerRadius = 10.0
        signupButton.clipsToBounds = true
        
        let imageTapGesture = UITapGestureRecognizer(target: self, action: #selector(EditProfileTableViewController.choosePictureAction))
        imageTapGesture.numberOfTapsRequired = 1
        view.addGestureRecognizer(imageTapGesture)
        
        userImageView.isUserInteractionEnabled = true
        userImageView.addGestureRecognizer(imageTapGesture)
        //create tap gesture to dismiss keyboard
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(EditProfileTableViewController.dismissKeyboard(gesture:)))
        
        tapGesture.numberOfTapsRequired = 1
        view.addGestureRecognizer(tapGesture)
        //create swipe gesture to dismiss keyboard
        let swipDown = UISwipeGestureRecognizer(target: self, action: #selector(EditProfileTableViewController.dismissKeyboard(gesture:)))
        swipDown.direction = .down
        view.addGestureRecognizer(swipDown)
        
        
    }
        
        
    
    
    
    @IBAction func signUpAction(_ sender: Any) {
        let data = UIImageJPEGRepresentation(self.userImageView.image!, 0.8)
        let email = emailTextfield.text!.lowercased()
        let finalEmail = email.trimmingCharacters(in: NSCharacterSet.whitespaces)
        let fullname = fullnametextField.text!
        let password = passwordTextfield.text!
        let street = streetTextField.text!
        let city = cityTextfield.text!
        let state = stateTextfield.text!
        let zip = zipcodeTextfield.text!
        let phone = phoneTextfield.text!
        let asksitter = textBox.text!
        let userimage = userImageView.image
        
        let imageData = UIImageJPEGRepresentation(userimage!, 0.8)
        
        if fullname.isEmpty || password.isEmpty || finalEmail.isEmpty || street.isEmpty || city.isEmpty || state.isEmpty || zip.isEmpty || phone.isEmpty || asksitter.isEmpty || data == nil {
            self.view.endEditing(true)
            
            let alertView = SCLAlertView()
            alertView.showError("😁OOPS😁", subTitle: "it seems like one of the Fields is empty. Please fill all the Fields and Try Again later.")
        } else {
            self.view.endEditing(true)
            
            authService.signUp(email: finalEmail, fullname: fullname, password: password, street: street, city: city, state: state, zipcode: zip, phone: phone,sitter: asksitter, data: imageData! as NSData)
        }
        
    }
    
    // Choosing User Picture
    func choosePictureAction(){
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.allowsEditing = true
        
        let alertController = UIAlertController(title: "Add a Picture", message: "choose from", preferredStyle: .actionSheet)
        
        let cameraAction = UIAlertAction(title: "Camera", style: .default) { (action) in
            
            if UIImagePickerController.isSourceTypeAvailable(.camera){
            pickerController.sourceType = .camera
            self.present(pickerController, animated: true, completion: nil)
            }else{
                print("Camera not available")
            }
        }
        
        let photosLibrary = UIAlertAction(title: "Photos Library", style: .default) { (action) in
            pickerController.sourceType = .photoLibrary
            self.present(pickerController, animated: true, completion: nil)
        }
        
        let savedPhotos = UIAlertAction(title: "Saved Photos Library", style: .default) { (action) in
            pickerController.sourceType = .savedPhotosAlbum
            self.present(pickerController, animated: true, completion: nil)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        
        alertController.addAction(cameraAction)
        alertController.addAction(photosLibrary)
        alertController.addAction(savedPhotos)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info [UIImagePickerControllerOriginalImage] as! UIImage
        self.dismiss(animated: true, completion: nil)
        self.userImageView.image = image
    }
    
    // Dismissing all editing actions when User Tap or Swipe down on the Main View
    func dismissKeyboard(gesture: UIGestureRecognizer){
        self.view.endEditing(true)
    }
    
    // Dismissing the Keyboard with the Return Keyboard Button
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        fullnametextField.resignFirstResponder()
        passwordTextfield.resignFirstResponder()
        emailTextfield.resignFirstResponder()
        streetTextField.resignFirstResponder()
        cityTextfield.resignFirstResponder()
        stateTextfield.resignFirstResponder()
        zipcodeTextfield.resignFirstResponder()
        phoneTextfield.resignFirstResponder()
        textBox.resignFirstResponder()
        
        return true
    }
    
    // Moving the View up after the Keyboard appears
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
    
    // MARK: - Picker view data source
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return list.count
    }

   
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }


    @IBAction func dismissTapped(_ sender: Any) {
        //self.navigationController?.popToRootViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func `switch`(_ sender: UISwitch) {
        if(sender.isOn == true){
            textBox.text = "YES! Am a PetSitter"
            // self.performSegue(withIdentifier: "update", sender: nil)
        }
        else{
            textBox.text = "NO! Am not a PetSitter"
        }
        
        
    }

    
    
   
}
