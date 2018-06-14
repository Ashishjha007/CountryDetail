//
//  CountryDetailCell.swift
//  CountryDetail
//
//  Created by Ashish jha on 6/12/18.
//  Copyright © 2018 xyz. All rights reserved.
//

import UIKit

class CountryDetailCell: UITableViewCell {

    @IBOutlet var imageVw: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    var detailModel: CountryDetailModel.Row? {
        didSet {
            guard let item = detailModel else { return }
            titleLabel?.text = item.title
            descriptionLabel?.text = item.description
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    static var nib:UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    
}
