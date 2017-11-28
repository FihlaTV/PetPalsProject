//
//  CustomizableImageView.swift
//  PetPalsProject
//
//  Created by ADENIKE TOMOMEWO on 11/15/17.
//  Copyright © 2017 ADENIKE TOMOMEWO. All rights reserved.
//

import Foundation

@IBDesignable class CustomizableImageView: UIImageView {
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        
        didSet {
            
            layer.cornerRadius = cornerRadius
            
        }
        
    }
    
}
