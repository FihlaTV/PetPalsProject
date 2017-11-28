//
//  ImageCell.swift
//  PetPalsProject
//
//  Created by ADENIKE TOMOMEWO on 9/12/17.
//  Copyright © 2017 ADENIKE TOMOMEWO. All rights reserved.
//

import UIKit

class ImageCell: UITableViewCell {
    
   

    @IBOutlet weak var parallaxImage: UIImageView!
    
    @IBOutlet weak var parallaxTopCon: NSLayoutConstraint!
    @IBOutlet weak var parallaxImageHeight: NSLayoutConstraint!
    @IBOutlet weak var imageTittle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        parallaxImage.clipsToBounds = true
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(title: String, image: UIImage){
        self.imageTittle.text = title
        self.parallaxImage.image = image
    }

}
