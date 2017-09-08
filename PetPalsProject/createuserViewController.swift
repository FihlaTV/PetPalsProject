//
//  createuserViewController.swift
//  PetPalsProject
//
//  Created by ADENIKE TOMOMEWO on 8/29/17.
//  Copyright © 2017 ADENIKE TOMOMEWO. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase

class createuserViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passWordField: UITextField!
    @IBOutlet weak var confirmPwdField: UITextField!

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var nextButton: UIButton!
    
    let picker = UIImagePickerController()
    var userStorage: StorageReference!
    var ref: DatabaseReference!
    override func viewDidLoad() {
        super.viewDidLoad()

        picker.delegate = self
        let storage = Storage.storage().reference(forURL: "gs://bestpetpal-c8d95.appspot.com")
        ref = Database.database().reference()
        userStorage = storage.child("users")
    }

    @IBAction func selectPicTapped(_ sender: Any) {
        picker.allowsEditing = true
        picker.sourceType = .photoLibrary
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
            self.imageView.image = image
            nextButton.isHidden = false
        }
        self.dismiss(animated: true, completion: nil)
    }
    

    @IBAction func nextTapped(_ sender: Any) {
        guard nameTextField.text != "", emailField.text != "", passWordField.text != "" else {
            return}
        
        if passWordField.text == confirmPwdField.text {
            Auth.auth().createUser(withEmail:emailField.text!, password: passWordField.text!, completion: { (user, error) in
                if let error = error {
                    print(error.localizedDescription)
                }
                if let user = user {
                    let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                    changeRequest?.commitChanges(completion: nil)
                    let imageRef = self.userStorage.child("\(user.uid).jpg")
                    let data = UIImageJPEGRepresentation(self.imageView.image!, 0.5)
                    let uploadTask = imageRef.putData(data!, metadata: nil, completion: { (metadata, err) in
                        if err != nil {
                            print(err!.localizedDescription)
                        }
                        
                        imageRef.downloadURL(completion: {(url, er) in
                            if er != nil {
                                print(er!.localizedDescription)
                            }
                            
                            if let url = url {
                                let userInfo: [String : Any] = ["uid" : user.uid, "full name": self.nameTextField.text!,
                                                                "urlToImage": url.absoluteString]
                                self.ref.child("users").child(user.uid).setValue(userInfo)
                                
                                let vc = UIStoryboard(name: "Main", bundle:nil).instantiateViewController(withIdentifier: "CustomersViewController")
                                self.present(vc, animated: true, completion: nil)
                            }
                        })
                    })
                    
                    uploadTask.resume()
                    
                }
            })
            
        } else {
            print("password does not match")
        }

    }
   }
