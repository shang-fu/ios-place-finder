//
//  CustomReviewCell.swift
//  Place Finder
//
//  Created by Hsieh Shang-Fu on 4/22/18.
//  Copyright © 2018 Hsieh Shang-Fu. All rights reserved.
//

import UIKit

class CustomReviewCell: UITableViewCell {

    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var rating: CosmosView!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var review: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
