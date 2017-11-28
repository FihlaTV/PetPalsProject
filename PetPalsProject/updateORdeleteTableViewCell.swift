//
//  updateORdeleteTableViewCell.swift
//  PetPalsProject
//
//  Created by ADENIKE TOMOMEWO on 10/31/17.
//  Copyright © 2017 ADENIKE TOMOMEWO. All rights reserved.
//

import UIKit

class updateORdeleteTableViewCell: UITableViewCell {
    @IBOutlet weak var lbName: UILabel!

    @IBOutlet weak var lblEmail: UILabel!
    
    @IBOutlet weak var lbStreet: UILabel!
    
    @IBOutlet weak var lbCity: UILabel!
    
    @IBOutlet weak var lbState: UILabel!
    
    @IBOutlet weak var lbZipCode: UILabel!
    //@IBOutlet weak var userImage: UIImageView!
    
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
