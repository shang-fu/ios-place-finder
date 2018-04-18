//
//  CustomPlaceCell.swift
//  Place Finder
//
//  Created by Hsieh Shang-Fu on 4/16/18.
//  Copyright © 2018 Hsieh Shang-Fu. All rights reserved.
//

import UIKit

class CustomPlaceCell: UITableViewCell {



    @IBOutlet var textView: UITextView!
    
    @IBOutlet var icon: UIImageView!
    
    @IBOutlet var heart: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
