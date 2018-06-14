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
    case theme
    case tableViewBackground
    case tableCellBackground
    case titleLabelText
    case descriptionLabelText
    // 1
    case custom(hexString: String, alpha: Double)
    // 2
    func withAlpha(_ alpha: Double) -> UIColor {
        return self.value.withAlphaComponent(CGFloat(alpha))
    }
}

extension Color {
    
    var value: UIColor {
        var instanceColor = UIColor.clear
        switch self {
        case .theme:
            instanceColor = UIColor.cyan//(red: <#T##CGFloat#>, green: <#T##CGFloat#>, blue: <#T##CGFloat#>, alpha: <#T##CGFloat#>)
        case .border:
            instanceColor = UIColor.clear
        case .navigationBarBackground:
            instanceColor = UIColor(red:213/255.0 , green: 126/255.0, blue: 208/255.0, alpha: 1.0)
        case .navigationBarText:
            instanceColor = UIColor.white
        case .tableViewBackground:
            instanceColor = UIColor.clear
        case .tableCellBackground:
            instanceColor = UIColor.clear
        case .titleLabelText:
            instanceColor = UIColor.blue//(red: <#T##CGFloat#>, green: <#T##CGFloat#>, blue: <#T##CGFloat#>, alpha: <#T##CGFloat#>)
        case .descriptionLabelText:
            instanceColor = UIColor.red//red: <#T##CGFloat#>, green: <#T##CGFloat#>, blue: <#T##CGFloat#>, alpha: <#T##CGFloat#>)
        case .custom(let hexValue, let opacity):
            instanceColor = UIColor(hexString: hexValue).withAlphaComponent(CGFloat(opacity))
            
        }
        return instanceColor
    }
}
