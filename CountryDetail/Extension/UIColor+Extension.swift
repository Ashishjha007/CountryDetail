//
//  UIColor+Extension.swift
//  CountryDetail
//
//  Created by Ashish jha on 6/13/18.
//  Copyright © 2018 xyz. All rights reserved.
//

import UIKit

extension UIColor {

    convenience init(hexString: String) {
        
        let hexString: String = (hexString as NSString).trimmingCharacters(in: .whitespacesAndNewlines)
        let scanner          = Scanner(string: hexString as String)
        
        if hexString.hasPrefix("#") {
            scanner.scanLocation = 1
        }
        var color: UInt32 = 0
        scanner.scanHexInt32(&color)
        
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        self.init(red:red, green:green, blue:blue, alpha:1)
    }
    
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
}

enum Color {
    case navigationBarBackground
    case navigationBarText
    case border
    case tableViewBackground
    case tableCellBackground
    case titleLabelText
    case descriptionLabelText
    case custom(hexString: String, alpha: Double)
    func withAlpha(_ alpha: Double) -> UIColor {
        return self.value.withAlphaComponent(CGFloat(alpha))
    }
}

extension Color {
    
    var value: UIColor {
        var color = UIColor.clear
        switch self {
        case .border:
            color = UIColor.clear
        case .navigationBarBackground:
            color = UIColor(red:213/255.0 , green: 126/255.0, blue: 208/255.0, alpha: 1.0)
        case .navigationBarText:
            color = UIColor.white
        case .tableViewBackground:
            color = UIColor.clear
        case .tableCellBackground:
            color = UIColor.clear
        case .titleLabelText:
            color = UIColor(red: 0/255.0, green: 84/255.0, blue: 147/255.0, alpha: 1.0)
        case .descriptionLabelText:
            color = UIColor(red: 148/255.0, green: 23/255.0, blue: 81/255.0, alpha: 1.0)
        case .custom(let hexValue, let opacity):
            color = UIColor(hexString: hexValue).withAlphaComponent(CGFloat(opacity))
        }
        return color
    }
}
