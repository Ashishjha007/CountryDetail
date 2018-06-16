//
//  CountryDetailCell.swift
//  CountryDetail
//
//  Created by Ashish jha on 6/12/18.
//  Copyright © 2018 xyz. All rights reserved.
//

import UIKit

class CountryDetailCell: UITableViewCell {

    @IBOutlet var thumbnailImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    var detailModel: CountryDetailModel.Row? {
        didSet {
            guard let item = detailModel else { return }
            self.titleLabel?.text = item.title
            self.descriptionLabel?.text = item.description
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.titleLabel.textColor = Color.titleLabelText.value
        self.descriptionLabel.textColor = Color.descriptionLabelText.value
        self.thumbnailImageView.circularImageView()
        self.layer.cornerRadius = 5
    }
    
    static var nib:UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    
}
