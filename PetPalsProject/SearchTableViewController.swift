//
//  SearchTableViewController.swift
//  PetPalsProject
//
//  Created by ADENIKE TOMOMEWO on 9/29/17.
//  Copyright © 2017 ADENIKE TOMOMEWO. All rights reserved.
//

import UIKit
import FirebaseDatabase

class SearchTableViewController: UITableViewController, UISearchResultsUpdating {
    
    @IBOutlet var petSittersTableView: UITableView!
    let searchController = UISearchController(searchResultsController: nil)
    var usersArray = [NSDictionary?]()
    var filteredUsers = [NSDictionary?]()
    var myindex = 0
    var databaseRef = Database.database().reference()
    override func viewDidLoad() {
        super.viewDidLoad()

        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        
        databaseRef.child("users").queryOrdered(byChild: "state").observe(.childAdded, with: {(snapshot) in
            self.usersArray.append(snapshot.value as? NSDictionary)
            
            //insert the rows
            self.petSittersTableView.insertRows(at: [IndexPath(row:self.usersArray.count-1, section:0)], with: UITableViewRowAnimation.automatic)
            
        }) { (error) in
            print(error.localizedDescription)
        }
    }

    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if searchController.isActive && searchController.searchBar.text != ""
        {
            return filteredUsers.count
        }
        return self.usersArray.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        myindex = indexPath.row
        performSegue(withIdentifier: "segue", sender: self)
    }

  
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        // Configure the cell...
        let user: NSDictionary?
        if searchController.isActive && searchController.searchBar.text != ""
        {
            user = filteredUsers[indexPath.row]
        }
        else{
            user = self.usersArray[indexPath.row]
        }
        
        cell.textLabel?.text = user?["city"] as? String
        cell.detailTextLabel?.text = user?["state"] as? String
        cell.detailTextLabel?.text = user?["sitter"] as? String

        return cell
    }
  
    @IBAction func dismissSearchViewController(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        filtereContent(searchText: self.searchController.searchBar.text!)
        
    }

        func filtereContent(searchText:String)
        {
            self.filteredUsers = self.usersArray.filter{ user in
                
                let username = user!["city"] as? String
                return(username?.lowercased().contains(searchText.lowercased()))!
            }
            tableView.reloadData()
        }
}
