//
//  Place.swift
//  Place Finder
//
//  Created by Hsieh Shang-Fu on 4/17/18.
//  Copyright © 2018 Hsieh Shang-Fu. All rights reserved.
//

import Foundation
import UIKit

class Place {
    let primaryKey : String // id in google search
    let id : String // place_id in google search
    let name : String
    let iconUrl : String
    let icon : UIImage
    let vicinity : String
    
    init(primaryKey : String, id : String, name : String, iconUrl : String, icon : UIImage, vicinity : String) {
        self.primaryKey = primaryKey
        self.id = id
        self.name = name
        self.iconUrl = iconUrl
        self.icon = icon
        self.vicinity = vicinity
    }
}
