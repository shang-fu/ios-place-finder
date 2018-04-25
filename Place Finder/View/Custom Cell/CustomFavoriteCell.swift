//
//  CustomFavoriteCell.swift
//  Place Finder
//
//  Created by Hsieh Shang-Fu on 4/23/18.
//  Copyright © 2018 Hsieh Shang-Fu. All rights reserved.
//

import UIKit

class CustomFavoriteCell: UITableViewCell {

    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var address: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}
