//
//  usersAccViewController.swift
//  PetPalsProject
//
//  Created by ADENIKE TOMOMEWO on 8/29/17.
//  Copyright © 2017 ADENIKE TOMOMEWO. All rights reserved.
//

import UIKit


class usersAccViewController: UIViewController {
   

    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var homeScrollView: UIScrollView!
    
    var imageArray = [UIImage]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
     imageArray = [#imageLiteral(resourceName: "imageBackground"), #imageLiteral(resourceName: "images2"),#imageLiteral(resourceName: "images4"), #imageLiteral(resourceName: "images6")]
        
        for i in 0..<imageArray.count{
            let imageView = UIImageView()
            imageView.image = imageArray[i]
            imageView.contentMode = .scaleAspectFit
            let xPosition = self.view.frame.width * CGFloat(i)
            imageView.frame = CGRect(x: xPosition, y: 0, width: self.homeScrollView.frame.width, height:self.homeScrollView.frame.height)
            homeScrollView.contentSize.width = homeScrollView.frame.width * CGFloat(i + 1)
            homeScrollView.addSubview(imageView)
            
        }
        
        sideMenus()
        //customizeNavBar()
        
    }
    
    func sideMenus() {
        if revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
           revealViewController().rearViewRevealWidth = 275
            revealViewController().rightViewRevealWidth = 160
            
           self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            
          
        }
    }
    
    }
