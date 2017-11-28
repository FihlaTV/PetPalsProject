//
//  EditProfileTableViewController.swift
//  PetPalsProject
//
//  Created by ADENIKE TOMOMEWO on 11/12/17.
//  Copyright © 2017 ADENIKE TOMOMEWO. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth
import FirebaseStorage

class EditProfileTableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    
    @IBOutlet weak var userImageView: UIImageView!
    
    @IBOutlet weak var fullnameTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var addressTextField: UITextField!
    
    @IBOutlet weak var cityTextField: UITextField!
    
    @IBOutlet weak var stateTextField: UITextField!
    
    @IBOutlet weak var zipCodeTextField: UITextField!
    
    @IBOutlet weak var phoneNum: UITextField!
    
    @IBOutlet weak var askSitter: UITextField!
    
    var pickerView: UIPickerView!
    var stateArrays = [String]()
    var user: Sitters!
    var userStorage: StorageReference!
    var databaseRef: DatabaseReference! {
        return Database.database().reference()
    }
    
    var storageRef: StorageReference! {
        return Storage.storage().reference()
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        fullnameTextField.delegate = self
        emailTextField.delegate = self
        addressTextField.delegate = self
        cityTextField.delegate = self
        stateTextField.delegate = self
        zipCodeTextField.delegate = self
        phoneNum.delegate = self
        askSitter.delegate = self
        
        userImageView.layer.cornerRadius = userImageView.layer.frame.height/2
        pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.backgroundColor = UIColor.black
        
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
    func fetchCurrentUserInfo(){
        let userRef = Database.database().reference().child("users").queryOrdered(byChild: "uid").queryEqual(toValue: Auth.auth().currentUser!.uid)
        
        userRef.observe(.value, with: { (snapshot) in
            for UserInfo in snapshot.children {
                self.user = Sitters(snapshot: UserInfo as! DataSnapshot)
            }
            if let user = self.user {
                self.fullnameTextField.text = user.fullname
                self.emailTextField.text = user.email
                self.addressTextField.text = user.address
                self.cityTextField.text = user.city
                self.stateTextField.text = user.state
                self.zipCodeTextField.text = user.zipcode
                self.phoneNum.text = user.phoneNumber
                self.askSitter.text = user.sitter
                
                
                //self.profileImage.sd_setImage(with: URL(string: user.urlto), /*completed: nil)
                
                Storage.storage().reference(forURL: user.urlto!).getData(maxSize: 10 * 1024 * 1024, completion: { (imgData, error) in
                    if let error = error {
                        let alertView = SCLAlertView()
                        alertView.showError("OOPS", subTitle: error.localizedDescription)
                        
                    }else{
                        DispatchQueue.main.async{
                            if let data = imgData {
                                self.userImageView.image = UIImage(data: data)
                            }
                        }
                    }
                    
                })
                
            }
        })

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        fetchCurrentUserInfo()

    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 && indexPath.row == 0 {
            self.choosePictureAction()
        }
    }
    
    func choosePictureAction(){
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.allowsEditing = true
        
        let alertController = UIAlertController(title: "Add a Picture", message: "choose from", preferredStyle: .actionSheet)
        let cameraAction = UIAlertAction(title: "Camera", style: .default) { (action) in
            pickerController.sourceType = .camera
            self.present(pickerController, animated: true, completion: nil)
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
    
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return stateArrays.count
    }
   
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
         let image = info[UIImagePickerControllerEditedImage] as? UIImage
       self.userImageView.image = image
         self.dismiss(animated: true, completion: nil)
    }
    
    func dismissKeyboard(gesture: UIGestureRecognizer){
        self.view.endEditing(true)
    }

    @IBAction func updateAction(_ sender: Any) {
        
        let email = emailTextField.text!.lowercased()
        let finalemail = email.trimmingCharacters(in: NSCharacterSet.whitespaces)
        let name = fullnameTextField.text!
        let addy = addressTextField.text!
        let city = cityTextField.text!
        let state = stateTextField.text!
        let zip = zipCodeTextField.text!
        let phonenum = phoneNum.text!
        let userPic = userImageView.image
        let askSit = askSitter.text!
        
        let imgData = UIImageJPEGRepresentation(userPic!, 0.8)!
        if finalemail.isEmpty || finalemail.characters.count < 8 || name.isEmpty || addy.isEmpty || city.isEmpty || state.isEmpty || zip.isEmpty || phonenum.isEmpty || askSit.isEmpty {
            let alertview = SCLAlertView()
            alertview.showError("OOPS", subTitle: "Hey, it seems like you did not fill the information correctly")
        }else {
            let imagePath = "urlToImage\(user.uid)/userPic.jpg"
            let imageRef = storageRef.child(imagePath)
            let metadata = StorageMetadata()
            metadata.contentType = "image/jpeg"
            
            imageRef.putData(imgData, metadata: metadata, completion: { (metadata, error) in
                if error == nil {
                    
                    Auth.auth().currentUser!.updateEmail(to: finalemail, completion: { (error) in
                        if error == nil{
                            print("Email updated sucessfully")
                        }else{
                            let alertview = SCLAlertView()
                            alertview.showError("OOPS", subTitle: error!.localizedDescription)
                        }
                    })
                    let changeRequest = Auth.auth().currentUser!.createProfileChangeRequest()
                    changeRequest.displayName = name
                    if let photoUrl = metadata?.downloadURL(){
                        changeRequest.photoURL = photoUrl
                        
                    
                    }
                    changeRequest.commitChanges(completion: { (error) in
                        if error == nil {
                            let user = Auth.auth().currentUser!
                            let userInfo = ["email": user.email!, "fullname": name, "street": addy, "city": city, "state": state, "phoneNumber": phonenum, "zipCode": zip,"sitter": askSit, "uid": user.uid, "urlToImage": String(describing: user.photoURL!)]
                            let userRef = self.databaseRef.child("users").child(user.uid)
                            userRef.setValue(userInfo, withCompletionBlock: { (error, ref) in
                                if error == nil {
                                    self.navigationController?.popToRootViewController(animated: true)
                                }else {
                                    let alertview = SCLAlertView()
                                    alertview.showError("OOPS", subTitle: error!.localizedDescription)
                                }
                            })
                        }else {
                            let alertview = SCLAlertView()
                            alertview.showError("OOPS", subTitle: error!.localizedDescription)
                            
                        }
                    })
                }
            })
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        fullnameTextField.resignFirstResponder()
        emailTextField.resignFirstResponder()
        addressTextField.resignFirstResponder()
        cityTextField.resignFirstResponder()
        stateTextField.resignFirstResponder()
        zipCodeTextField.resignFirstResponder()
        askSitter.resignFirstResponder()
        phoneNum.resignFirstResponder()
        return true
    }
   
    @IBAction func switchAction(_ sender: UISwitch) {
        if(sender.isOn == true){
            askSitter.text = "YES! Am a PetSitter"
            // self.performSegue(withIdentifier: "update", sender: nil)
        }
        else{
            askSitter.text = "NO! Am not a PetSitter"
        }
        
        }
   }
