//
//  SettingsTableViewController.swift
//  PetPalsProject
//
//  Created by ADENIKE TOMOMEWO on 11/7/17.
//  Copyright © 2017 ADENIKE TOMOMEWO. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth
import FirebaseStorage

class SettingsTableViewController: UITableViewController {

    @IBOutlet weak var userImageView: UIImageView!
    
    @IBOutlet weak var userlabelName: UILabel!
    
    
    @IBOutlet weak var userEmail: UILabel!
    var user: Sitters!
           override func viewDidLoad() {
        super.viewDidLoad()

        userImageView.layer.cornerRadius = userImageView.layer.frame.width/2
        

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        let userRef = Database.database().reference().child("users").queryOrdered(byChild: "uid").queryEqual(toValue: Auth.auth().currentUser!.uid)
        
        userRef.observe(.value, with: { (snapshot) in
            for UserInfo in snapshot.children {
               self.user = Sitters(snapshot: UserInfo as! DataSnapshot)
            }
                if let user = self.user {
                    self.userlabelName.text = user.fullname
                    self.userEmail.text = user.email
                
                   
                    Storage.storage().reference(forURL: user.urlto!).getData(maxSize: 10 * 1024 * 1024, completion: { (imgdata, error) in
                        if let error = error {
                            let alertview = SCLAlertView()
                            alertview.showError("OOPS", subTitle: error.localizedDescription)
                        }else{
                            DispatchQueue.main.async{
                            if let data = imgdata {
                                self.userImageView.image = UIImage(data: data)
                            }
                                
                           
                                
                            }
                        }
                    })
            
            }
            
            
            
            
            
            
        }) { (error) in
            
            let alertView = SCLAlertView()
            alertView.showError("😁OOPS😁", subTitle: error.localizedDescription)
        }
        
        
        
        
    }
    
    func deleteAccount() {
        let alertView1 = SCLAlertView()
        alertView1.addButton("Delete") { 
            let currentUserRef = Database.database().reference().child("users").queryOrdered(byChild: "uid").queryEqual(toValue: Auth.auth().currentUser!.uid)
            currentUserRef.observe(.value, with: { (snapshot) in
                for user in snapshot.children {
                    let currentUser = Sitters(snapshot: user as! DataSnapshot)
                    
                    currentUser.ref?.removeValue(completionBlock: { (error, ref) in
                        if error == nil {
                            Auth.auth().currentUser?.delete(completion: { (error) in
                                if error == nil {
                                    print("account successfully deleted")
                                    //DispatchQueue.main.async{
                                        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Login") as! LoginViewController
                                        self.present(vc, animated: true, completion: nil)
                                    //}
                                }else{
                                    let alertView = SCLAlertView()
                                    alertView.showError("OOPS", subTitle: error!.localizedDescription)
                                }
                            })
                        }else{
                            let alertView = SCLAlertView()
                            alertView.showError("OOPS", subTitle: error!.localizedDescription)
                        }
                    })
                }
            }) { (error) in
                let alertView = SCLAlertView()
                alertView.showError("OOPS", subTitle: error.localizedDescription)
            }
        }
        alertView1.showWarning("Warning", subTitle: "Are you sure you want to delete your Account?")
    }
    
    func resestPassword(){
        let email = Auth.auth().currentUser!.email!
        AuthenticationService().resetPassword(email: email)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 2 && indexPath.row == 0 {
            deleteAccount()
        }else if indexPath.section == 1 && indexPath.row == 0{
            resestPassword()
        }
    }
        
}
