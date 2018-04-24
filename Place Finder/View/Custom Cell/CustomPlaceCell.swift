//
//  CustomPlaceCell.swift
//  Place Finder
//
//  Created by Hsieh Shang-Fu on 4/16/18.
//  Copyright © 2018 Hsieh Shang-Fu. All rights reserved.
//

import UIKit

protocol HeartButtonsDelegate{
    func filledHeartTapped(placeName: String)
    func emptyHeartTapped(placeName: String)
}

class CustomPlaceCell: UITableViewCell {

    var delegate: HeartButtonsDelegate!

    @IBOutlet var textView: UILabel!
    @IBOutlet var icon: UIImageView!

    @IBOutlet var heart: UIButton!
    
//    let fav = UIImage(named: "favorite-filled")
//    let notfav = UIImage(named: "favorite-empty")
    var isFav = false
    var placeName = ""
    var place : Place?
    
    let defaults = UserDefaults.standard
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
//    @IBAction func hearClicked(_ sender: UIButton) {
//        if (isFav) {
//            // turn to not fav
//            isFav = false
//            heart.setBackgroundImage(notfav, for: UIControlState.normal)
//        } else {
//            // turn to fav
//            isFav = true
//            heart.setBackgroundImage(fav, for: UIControlState.normal)
//        }
//    }
    
    
    @IBAction func heartImageClicked(_ sender: UIButton) {
        if (isFav) {
            // turn to not fav
            self.delegate?.filledHeartTapped(placeName: self.placeName)
            isFav = false
            heart.setBackgroundImage(UIImage(named: "favorite-empty"), for: UIControlState.normal)
            if let place = place {
                defaults.removeObject(forKey: place.primaryKey)
            }
        } else {
            // turn to fav
            self.delegate?.emptyHeartTapped(placeName: self.placeName)
            isFav = true
            heart.setBackgroundImage(UIImage(named: "favorite-filled"), for: UIControlState.normal)
            
            if let place = place {
                let dictionary = [
                    "primaryKey" : place.primaryKey,
                    "id" : place.id,
                    "name" : place.name,
                    "iconUrl" : place.iconUrl,
                    "vicinity" : place.vicinity,
                    "time" : String(NSDate().timeIntervalSince1970)
                    ]
                defaults.set(dictionary, forKey: place.primaryKey)
            }
            
        }
    }
    
}
