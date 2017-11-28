//
//  MySQLDatabaseViewController.swift
//  PetPalsProject
//
//  Created by ADENIKE TOMOMEWO on 10/9/17.
//  Copyright © 2017 ADENIKE TOMOMEWO. All rights reserved.
//

import UIKit

class MySQLDatabaseViewController: UIViewController , UITableViewDataSource, UISearchBarDelegate{
    @IBOutlet weak var mySearchBar: UITableView!
    
    @IBOutlet weak var myTableView: UITableView!
    var searchResults = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let myCell = tableView.dequeueReusableCell(withIdentifier: "myCell")
        
        return myCell!
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if(searchBar.text!.isEmpty)
        {
            return
        }
        
        doSearch(searchWord: searchBar.text!)
        
    }
    
    func doSearch(searchWord: String)
    {
        mySearchBar.resignFirstResponder()
        
        let myUrl = "http://localhost/UISearchBarCaseInsensitiveSearch/join.php"
        
        let request = URL(string: myUrl)
      // request?.absoluteString = "POST";
        
        let postString = "searchWord=\(searchWord)&userId=23";
       // request!.host = postString.data(using: String.Encoding.utf8);
        let session = URLSession.shared
        
        let task = session.dataTask(with: request!) { (data, response, error) in
    DispatchQueue.main.async() {
                
                if error != nil
                {
                     //display an alert message
                    self.displayAlertMessage(userMessage: error!.localizedDescription)
                    return
                }
            
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                    
                    self.searchResults.removeAll(keepingCapacity: false)
                    self.myTableView.reloadData()
                    
                  if let parseJSON = json {
                        
                        if let friends  = parseJSON["friends"] as? [AnyObject]
                        {
                            for friendObj in friends
                            {
                                let fullName = (friendObj["fName"] as! String) + " " + (friendObj["lName"] as! String)
                                
                                self.searchResults.append(fullName)
                            }
                            
                            self.myTableView.reloadData()
                            
                        } else if(parseJSON["message"] != nil)
                        {
                            
                            let errorMessage = parseJSON["message"] as? String
                            if(errorMessage != nil)
                            {
                                // display an alert message
                                self.displayAlertMessage(userMessage: errorMessage!)
                            }
                        }
                    }
                    
                } catch {
                    print(error);
                }
            }
            }
    
            task.resume()
        
        
        }
    

    
    func displayAlertMessage(userMessage: String)
    {
        let myAlert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: UIAlertControllerStyle.alert);
        let okAction =  UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil)
        myAlert.addAction(okAction);
        self.present(myAlert, animated: true, completion: nil)
    }
    
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
      //  mySearchBar.text! = ""
        mySearchBar.resignFirstResponder()
    }

}
