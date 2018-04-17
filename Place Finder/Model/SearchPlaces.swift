//
//  SearchPlaces.swift
//  Place Finder
//
//  Created by Hsieh Shang-Fu on 4/16/18.
//  Copyright © 2018 Hsieh Shang-Fu. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class SearchPlaces {
    let url = "https://travel-entertain-search.appspot.com/search"
    
    func getPlaces(parameters: [String: String]) {
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON {
            response in
            if response.result.isSuccess {
                
                print("Success! Got the weather data")
                print(response)
                let placesJSON : JSON = JSON(response.result.value!)
                
                
                print(placesJSON)
                
            }
            else {
                print("Error \(String(describing: response.result.error))")
            }
        }
    }
}
