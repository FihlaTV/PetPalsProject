//
//  homeImageCell.swift
//  PetPalsProject
//
//  Created by ADENIKE TOMOMEWO on 9/12/17.
//  Copyright © 2017 ADENIKE TOMOMEWO. All rights reserved.
//

import UIKit

class homeImageCell: UITableViewCell {

    @IBOutlet weak var imageTopCon: NSLayoutConstraint!
    @IBOutlet weak var imageHeight: NSLayoutConstraint!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var imageParallax: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imageParallax.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
    }
    
    func configureCell(title: String, image: UIImage){
        self.label.text = title
        self.imageParallax.image = image
    }


}
