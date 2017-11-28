//
//  CustomizableButton.swift
//  PetPalsProject
//
//  Created by ADENIKE TOMOMEWO on 11/15/17.
//  Copyright © 2017 ADENIKE TOMOMEWO. All rights reserved.
//

import Foundation
@IBDesignable class CustomizableButton: UIButton {
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        
        didSet {
            
            layer.cornerRadius = cornerRadius
            
        }
        
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        
        didSet {
            
            layer.borderWidth = borderWidth
        }
        
    }
    
    @IBInspectable var borderColor: CGColor? = UIColor.white.cgColor {
        
        didSet {
            
            layer.borderColor = borderColor
        }
        
    }
    
}
