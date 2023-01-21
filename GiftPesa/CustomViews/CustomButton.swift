//
//  CustomButton.swift
//  GiftPesa
//
//  Created by Lawrence Magerer on 20/01/2023.
//

import UIKit
@IBDesignable
 class CustomButton: UIButton {
    
    //let CL = Colors()
    
    @IBInspectable var borderWidth: CGFloat = 0.0{
        
        didSet{
            
            self.layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor = UIColor.clear {
        
        didSet {
            
            self.layer.borderColor = borderColor.cgColor
        }
    }
    @IBInspectable var cornerRadius: CGFloat {
        
        get{
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    override func prepareForInterfaceBuilder() {
        
        super.prepareForInterfaceBuilder()
    }
    
}

