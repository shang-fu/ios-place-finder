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
    let id : String
    let name : String
    let icon : UIImage
    let vicinity : String
    
    init(id : String, name : String, icon : UIImage, vicinity : String) {
        self.id = id
        self.name = name
        self.icon = icon
        self.vicinity = vicinity
    }
}
