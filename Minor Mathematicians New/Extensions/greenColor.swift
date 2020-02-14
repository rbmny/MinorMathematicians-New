//
//  greenColor.swift
//  Minor Mathematicians
//
//  Created by Ricardo Aguiar Bomeny on 26/01/20.
//  Copyright © 2020 Ricardo Aguiar Bomeny. All rights reserved.
//

import UIKit

extension UIColor {
    static let universalGreen = 0
    
    func colorFromHex(_ hex : String) -> UIColor {
        var hexString = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if hexString.hasPrefix("#") {
            hexString.remove(at: hexString.startIndex)
        }
        
        if hexString.count != 6 {
            return UIColor.black
        }
        
        var rgb : UInt64 = 0
        Scanner(string: hexString).scanHexInt64(&rgb)
        
        return UIColor.init(red: (((rgb & 0xFF0000) > 16)/255.0), green: <#T##CGFloat#>, blue: <#T##CGFloat#>, alpha: <#T##CGFloat#>)
    }
}
