//
//  YelpReviewsRequest.swift
//  Place Finder
//
//  Created by Hsieh Shang-Fu on 4/22/18.
//  Copyright © 2018 Hsieh Shang-Fu. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class YelpReviewsRequest {
    let url = "https://travel-entertain-search.appspot.com/yelp"
    
    
    func getReviews(name: String, address: String, completion: @escaping (JSON) -> Void) {

        let yelpAddress : [String] = address.components(separatedBy: ", ")

        var address1 : String = ""
        for index in 0...yelpAddress.count - 3 {
            address1 += "\(yelpAddress[index]), "
        }

        let indexEndOfText = address1.index(address1.endIndex, offsetBy: -2)
        let address1_sub = String(address1[..<indexEndOfText])

        let parameters : [String : String] = [
            "name": name,
            "address1": address1_sub,
            "address2": yelpAddress[yelpAddress.count - 3],
            "address3": yelpAddress[yelpAddress.count - 2],
            "city": yelpAddress[yelpAddress.count - 3],
            "state": yelpAddress[yelpAddress.count - 2].components(separatedBy: " ")[0],
            "country": "US"
        ]

        print(name)
        print(address1_sub)
        print(yelpAddress[yelpAddress.count - 3])
        print(yelpAddress[yelpAddress.count - 2])
        print(yelpAddress[yelpAddress.count - 3])
        print(yelpAddress[yelpAddress.count - 2].components(separatedBy: " ")[0])
        
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON(completionHandler:  {
            response -> Void in
            if response.result.isSuccess {
                print(response.request!)  // original URL request
//                print(response.response!) // HTTP URL response
//                print(response.data!)     // server data
//                print(response.result)   // result of response serialization
                print("Success! Got Yelp reviews")
                let yelpReviewsJSON : JSON = JSON(response.result.value!)
                completion(yelpReviewsJSON)
                
            }
            else {
                print("Error \(String(describing: response.result.error))")
                print(response.request!)
            }
        })
        
    }
}
