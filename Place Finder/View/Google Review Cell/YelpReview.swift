//
//  YelpReview.swift
//  Place Finder
//
//  Created by Hsieh Shang-Fu on 4/22/18.
//  Copyright © 2018 Hsieh Shang-Fu. All rights reserved.
//

import Foundation

class YelpReview {
    var name : String
    var url : String
    var photo : String
    var rating : String
    var text : String
    var time : String
    
    init(name : String, url : String, photo : String, rating : String, text : String, time : String) {
        self.name = name
        self.url = url
        self.photo = photo
        self.rating = rating
        self.text = text
        self.time = time
    }
}
