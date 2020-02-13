//
//  roundBtn.swift
//  NHS
//
//  Created by Ricardo Aguiar Bomeny on 17/05/19.
//  Copyright © 2019 Ricardo Aguiar Bomeny. All rights reserved.
//

import UIKit

@IBDesignable

class roundBtn: UIButton {
    
    func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }


    func customizeView() {
        layer.cornerRadius = 25
        backgroundColor = UIColorFromRGB(rgbValue: 0x3caea3)
        setTitleColor(UIColor.black, for: .normal)
        contentHorizontalAlignment = .center
        contentVerticalAlignment = .center
        contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        titleLabel?.font = UIFont(name: "Avenir-Medium", size: 22)
    }
    
    override func awakeFromNib(){
    super.awakeFromNib()
         customizeView()
        

        
    }
    

    override func prepareForInterfaceBuilder() {
        customizeView()
    }

    
}
