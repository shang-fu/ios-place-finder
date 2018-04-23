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
    let url = "https://travel-entertain-search.appspot.com/detail"
    var placeid = ""
    
    func getDetail(completion: @escaping (JSON) -> Void) {
        let parameters : [String : String] = ["placeid" : placeid]
        
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON(completionHandler:  {
            response -> Void in
            if response.result.isSuccess {
                print(response.request!)  // original URL request
//                print(response.response!) // HTTP URL response
//                print(response.data!)     // server data
//                print(response.result)   // result of response serialization
                print("Success! Got the place detail")
                let detailJSON : JSON = JSON(response.result.value!)
                completion(detailJSON)
                
            }
            else {
                print("Error \(String(describing: response.result.error))")
            }
        })
    
    }
    
}
