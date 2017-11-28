//
//  AuthenticationService.swift
//  PetPalsProject
//
//  Created by ADENIKE TOMOMEWO on 11/15/17.
//  Copyright © 2017 ADENIKE TOMOMEWO. All rights reserved.
//

import Foundation

import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase


struct AuthenticationService {
    
    var databaseRef: DatabaseReference! {
        
        return Database.database().reference()
    }
    
    var storageRef: StorageReference! {
        
        return Storage.storage().reference()
    }
    
    // 3 - We save the user info in the Database
    private func saveInfo(user: User!, fullname: String, password: String, street: String, city: String, state: String, zipcode: String, phone: String, sitter: String){
        
        let userInfo = ["email": user.email!, "fullname": fullname, "street": street, "city": city,"state": state,"zipCode":zipcode,"phoneNumber":phone, "uid": user.uid, "sitter": sitter, "urlToImage": String(describing: user.photoURL!)]
        
        let userRef = databaseRef.child("users").child(user.uid)
        
        userRef.setValue(userInfo)
        
        signIn(email: user.email!, password: password)
        
        
    }
    
    // 4 - We sign in the User
    func signIn(email: String, password: String){
        Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in
            if error == nil {
                
                if let user = user {
                    
                    print("\(user.displayName!) has signed in successfuly")
                    
                    let appDel: AppDelegate = UIApplication.shared.delegate as! AppDelegate
                    appDel.logUser()
                }
                
            }else {
                
                let alertView =  SCLAlertView()
                alertView.showError("😁OOPS😁", subTitle: error!.localizedDescription)
                
            }
        })
        
    }
    
    // 1 - We create firstly a New User
    func signUp(email: String, fullname: String, password: String, street: String, city: String, state: String, zipcode: String,phone: String,sitter: String, data: NSData!){
        
        Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
            if error == nil {
                
                self.setUserInfo(user: user, fullname: fullname, password: password, street: street, city: city,state:state, zipcode: zipcode, phone: phone,sitter: sitter, data: data)
                
                
            }else {
                DispatchQueue.main.async(execute: {
                let alertView =  SCLAlertView()
                alertView.showError("😁OOPS😁", subTitle: error!.localizedDescription)
                })
            }
            
        })
        
    }
    
    func resetPassword(email: String){
        
        Auth.auth().sendPasswordReset(withEmail: email, completion: { (error) in
            if error == nil {
                
                DispatchQueue.main.async(execute: {
                    let alertView =  SCLAlertView()
                    
                    alertView.showSuccess("Resetting Password", subTitle: "An email containing the different information on how to reset your password has been sent to \(email)")
                })
                
                
                
            }else {
                
                let alertView =  SCLAlertView()
                alertView.showError("😁OOPS😁", subTitle: error!.localizedDescription)
            }
        })
        
    }
    
    // 2 - We set the User Info
    private func setUserInfo(user: User!, fullname: String, password: String, street: String, city: String, state:String,zipcode: String, phone: String,sitter: String, data: NSData!){
        
        let imagePath = "profileImage\(user.uid)/userPic.jpg"
        
        let imageRef = storageRef.child(imagePath)
        
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        
        imageRef.putData(data as Data, metadata: metadata) { (metadata, error) in
            if error == nil {
                
                let changeRequest = user.createProfileChangeRequest()
                changeRequest.displayName = fullname
                
                if let photoURL = metadata!.downloadURL(){
                    changeRequest.photoURL = photoURL
                }
                
                changeRequest.commitChanges(completion: { (error) in
                    if error == nil {
                        
                        self.saveInfo(user: user, fullname: fullname, password: password, street: street, city: city,state:state, zipcode: zipcode, phone: phone, sitter:sitter)
                    }
                    else {
                        
                        let alertView =  SCLAlertView()
                        alertView.showError("😁OOPS😁", subTitle: error!.localizedDescription)
                        
                    }
                    
                })
            }else {
                
                let alertView =  SCLAlertView()
                alertView.showError("😁OOPS😁", subTitle: error!.localizedDescription)
                
                
            }
        }
        
    }
}
