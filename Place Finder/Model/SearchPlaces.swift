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
    var pageOne : JSON?
    var pageTwo : JSON?
    var pageThr : JSON?
    var currentPage : JSON?
    var currentPageNum : Int?
    var nextPageToken : String?
    
    func getPlaces(parameters: [String: String]) {
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON {
            response in
            if response.result.isSuccess {
                
                print("Success! Got the weather data")
//                print(response)
                let placesJSON : JSON = JSON(response.result.value!)
                self.pageOne = placesJSON["results"]
                self.currentPage = self.pageOne
                self.currentPageNum = 1
                self.nextPageToken = placesJSON["next_page_token"].stringValue
            }
            else {
                print("Error \(String(describing: response.result.error))")
            }
        }
    }
}
