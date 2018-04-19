//
//  SearchPlaceDetail.swift
//  Place Finder
//
//  Created by Hsieh Shang-Fu on 4/18/18.
//  Copyright © 2018 Hsieh Shang-Fu. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class SearchPlaceDetail {
    let url = "https://maps.googleapis.com/maps/api/place/details/json"
    var placeid = ""
    let key = "AIzaSyD9U0CyQnxAKHk7Hcpjlf0A0ElNpP-zBdk"
    
    func getDetail() {
        let parameters : [String : String] = ["placeid" : placeid, "key" : key]
        
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON(completionHandler:  {
            response -> Void in
            if response.result.isSuccess {
                
                print("Success! Got the place detail")
                let detailJSON : JSON = JSON(response.result.value!)
                print(detailJSON)
                
            }
            else {
                print("Error \(String(describing: response.result.error))")
            }
        })
    
    }
    
}
