//
//  homePageViewController.swift
//  PetPalsProject
//
//  Created by ADENIKE TOMOMEWO on 9/7/17.
//  Copyright © 2017 ADENIKE TOMOMEWO. All rights reserved.
//

import UIKit

class homePageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var titles = ["Best website to get a pet sitter", "Tell us about your pet", "Our petsitters are most qualified", "upload your pet on your profile", "call us for more Info"]
    var images: [UIImage] = [
        
        UIImage(named: "images2")!,
        UIImage(named: "images3")!,
        UIImage(named: "images4")!,
        UIImage(named: "images5")!,
        UIImage(named: "images6")!
    ]

    
    var parallaxOffSetSpeed = 30
    var cellHeight: CGFloat = 250

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
    }
    var parallaxImageHeight: CGFloat {
        let maxOffset = (sqrt(pow(cellHeight, 2) + 4 * CGFloat(parallaxOffSetSpeed) * self.tableView.frame.height) - cellHeight / 2)
        return maxOffset + self.cellHeight
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "homeImageCell") as? homeImageCell {
            cell.configureCell(title: titles[indexPath.row], image: images[indexPath.row])
            cell.imageHeight.constant = self.parallaxImageHeight
            cell.imageTopCon.constant = parallaxOffset(newOffsetY: tableView.contentOffset.y, cell: cell)
           
            return cell
        }else {
            return homeImageCell()
        }
        

    }
    func parallaxOffset(newOffsetY: CGFloat, cell: UITableViewCell) -> CGFloat {
        
        return (newOffsetY - cell.frame.origin.y) / CGFloat(parallaxImageHeight) *  CGFloat(parallaxOffSetSpeed)
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
      let cell = tableView.contentOffset.y
        for cell in tableView.visibleCells as! [homeImageCell] {
            cell.imageTopCon.constant = parallaxOffset(newOffsetY: tableView.contentOffset.y, cell: cell)
            
        }
    }

    
    @IBAction func logOutTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)

    }

   }
