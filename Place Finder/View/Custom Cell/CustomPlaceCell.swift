//
//  CustomPlaceCell.swift
//  Place Finder
//
//  Created by Hsieh Shang-Fu on 4/16/18.
//  Copyright © 2018 Hsieh Shang-Fu. All rights reserved.
//

import UIKit

class CustomPlaceCell: UITableViewCell {


    @IBOutlet var textView: UILabel!
    @IBOutlet var icon: UIImageView!

    @IBOutlet var heart: UIButton!
    
    let fav = UIImage(named: "favorite-filled")
    let notfav = UIImage(named: "favorite-empty")
    var isFav = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func hearClicked(_ sender: UIButton) {
        if (isFav) {
            // turn to not fav
            isFav = false
            heart.setBackgroundImage(notfav, for: UIControlState.normal)
        } else {
            // turn to fav
            isFav = true
            heart.setBackgroundImage(fav, for: UIControlState.normal)
        }
    }
    
}
