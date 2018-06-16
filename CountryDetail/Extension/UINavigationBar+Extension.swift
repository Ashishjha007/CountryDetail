//
//  UINavigationBar+Extension.swift
//  CountryDetail
//
//  Created by Ashish jha on 6/13/18.
//  Copyright © 2018 xyz. All rights reserved.
//

import UIKit

extension UINavigationBar
{
    func setupNavigationBar() {
        barTintColor = Color.navigationBarBackground.value
        let titleDict: NSDictionary = [
            NSAttributedStringKey.foregroundColor: Color.navigationBarText.value,
            NSAttributedStringKey.font: UIFont(name: "Helvetica-Bold", size: 18)! ]
        titleTextAttributes = titleDict as? [NSAttributedStringKey : Any]
    }
}
