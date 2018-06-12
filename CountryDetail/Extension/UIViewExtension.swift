//
//  UIViewExtension.swift
//  CountryDetail
//
//  Created by Ashish jha on 6/12/18.
//  Copyright © 2018 xyz. All rights reserved.
//

import UIKit

extension UIView {
    
    func addGradientBackground(from topColor : UIColor, to bottomColor : UIColor ) {
        let gradient = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = [topColor.cgColor, bottomColor.cgColor];
        self.layer.insertSublayer(gradient, at: 0)
    }
    
    func updateGradientFrame() {
        let gradient = self.layer.sublayers![0] as! CAGradientLayer
        gradient.frame = self.bounds
    }
}
