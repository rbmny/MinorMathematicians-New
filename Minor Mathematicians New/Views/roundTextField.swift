//
//  roundTextField.swift
//  NHS
//
//  Created by Ricardo Aguiar Bomeny on 16/05/19.
//  Copyright © 2019 Ricardo Aguiar Bomeny. All rights reserved.
//

import UIKit

@IBDesignable

class roundTextField: UITextField {
    
    func customizeView(){
        textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        layer.cornerRadius = 15.0
        alpha = 1
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        customizeView()
    }
    override func prepareForInterfaceBuilder() {
        customizeView()
    }

}
