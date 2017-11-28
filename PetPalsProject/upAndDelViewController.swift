//
//  upAndDelViewController.swift
//  PetPalsProject
//
//  Created by ADENIKE TOMOMEWO on 10/31/17.
//  Copyright © 2017 ADENIKE TOMOMEWO. All rights reserved.
//
/*
import UIKit
import FirebaseDatabase
import FirebaseAuth
import FirebaseStorage

class upAndDelViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var imageView: UITableView!
    
    @IBOutlet weak var labelText: UILabel!
var refUser: DatabaseReference!
    var users = [Users]()
    override func viewDidLoad() {
        super.viewDidLoad()
        refUser = Database.database().reference().child("users");
        refUser.observe(DataEventType.value, with: { (snapshot) in
           
            if snapshot.childrenCount>0 {
                self.users.removeAll()
                
                for userss in snapshot.children.allObjects as![DataSnapshot]{
                    let userobj = userss.value as? [String: AnyObject]
                    let usernmae = userobj?["fullname"]
                    let useremail = userobj?["email"]
                    let userid = userobj?["uid"]
                    let usraddy = userobj?["street "]
                    let usrcity = userobj?["city"]
                    let usrstate = userobj?["state"]
                    let usrzip = userobj?["zipCode"]
                    //let userimage = userobj?["urlToImage"]
                    
                    let userC = Users(uid: userid as? String, fullname: usernmae as? String, email: useremail as? String, address: usraddy as? String, city: usrcity as? String, state: usrstate as? String, zipcode: usrzip as? String)
                        
                        self.users.append(userC)
                }
                self.imageView.reloadData()
            }
        })
        
           }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! updateORdeleteTableViewCell
        let user: Users
        user = users[indexPath.row]
        cell.lbName.text = user.fullname
        cell.lblEmail.text = user.email
        cell.lbStreet.text = user.address
        cell.lbCity.text = user.city
        cell.lbState.text = user.state
        cell.lbZipCode.text = user.zipcode
      //  cell.userImage = user.urlto
        
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = users[indexPath.row]
        let alertController = UIAlertController(title: user.fullname, message: "Give me the new name you want to update", preferredStyle: .alert)
        
        let updateAction = UIAlertAction(title: "Update", style: .default) { (_) in
            let id = user.uid
            let name = alertController.textFields?[0].text
            let Email = alertController.textFields?[1].text
            let address = alertController.textFields?[2].text
            let city = alertController.textFields?[3].text
            let state = alertController.textFields?[4].text
            let zip = alertController.textFields?[5].text
           // let image = user.urlto
            
            self.updateProfile(id: id!, name: name!, Email: Email!, address: address!, city: city!, state: state!, zip: zip!)
        }
        
        let deletAction = UIAlertAction(title: "Delete", style: .default) { (_) in
            self.deleteUser(id: user.uid!)
        }
        
        alertController.addTextField { (textField) in
            textField.text = user.fullname
        }
        
        alertController.addTextField { (textField) in
            textField.text = user.email
        }
        alertController.addTextField { (textField) in
            textField.text = user.address
        }
        
        alertController.addTextField { (textField) in
            textField.text = user.city
        }
        
        alertController.addTextField { (textField) in
            textField.text = user.state
        }
        alertController.addTextField { (textField) in
            textField.text = user.zipcode
        }

        
        alertController.addAction(updateAction)
        alertController.addAction(deletAction)
        present(alertController, animated: true, completion: nil)

    }
    
    func updateProfile(id: String, name: String, Email: String, address: String, city: String, state: String, zip: String){
        let cust = [
            "uid": id,
            "fullname": name,
            "email": Email,
            "address": address,
            "city": city,
            "state": state,
            "zipCode": zip
            //"urlto": image
        ] as [String : Any]
        
       // refUser.child(id).setValue(cust)
        refUser.child(id).updateChildValues(cust)
        labelText.text = "User Updated"
    }
    
    
    func deleteUser(id: String) {
        refUser.child(id).setValue(nil)
        labelText.text = " User Deleted"
    }
    

}*/
