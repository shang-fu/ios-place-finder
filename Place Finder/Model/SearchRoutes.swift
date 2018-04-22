//
//  SearchRoutes.swift
//  Place Finder
//
//  Created by Hsieh Shang-Fu on 4/21/18.
//  Copyright © 2018 Hsieh Shang-Fu. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON


class SearchRoutes {
    var originAddress : String = ""
    var originLat : String = ""
    var originLng : String = ""
    var destinationLat : String = ""
    var destinationLng : String = ""
    var mode : String = ""
    let key : String = "AIzaSyB3dnuPAp8cYepOLvCjzdUEnlKI3KB0arU"
    
    func findRoutes(completion: @escaping (JSON) -> Void) {
        let formattedOriginAddress = originAddress.replacingOccurrences(of: " ", with: "+")
        
        let geolocationUrl = "https://maps.googleapis.com/maps/api/geocode/json"
        let geolocationParameters : [String : String] = ["address" : formattedOriginAddress, "key" : key]
        
        Alamofire.request(geolocationUrl, method: .get, parameters: geolocationParameters).responseJSON(completionHandler:  {
            response -> Void in
            if response.result.isSuccess {

                print("Success! Got the origin place geolocation")
                let originGeolocationJSON : JSON = JSON(response.result.value!)
                self.originLat = originGeolocationJSON["results"][0]["geometry"]["location"]["lat"].stringValue
                self.originLng = originGeolocationJSON["results"][0]["geometry"]["location"]["lng"].stringValue
                
//                print(self.originLat)
//                print(self.originLng)
//                print(self.destinationLat)
//                print(self.destinationLng)
                
                let directionRouteUrl = "https://maps.googleapis.com/maps/api/directions/json"
                let directionRouteParameters : [String : String] = ["origin" : "\(self.originLat),\(self.originLng)", "destination" : "\(self.destinationLat),\(self.destinationLng)", "mode" : self.mode, "key" : self.key]
                
                Alamofire.request(directionRouteUrl, method: .get, parameters: directionRouteParameters).responseJSON(completionHandler:  {
                    response -> Void in
                    if response.result.isSuccess {
                        
//                        print(response.request!)  // original URL request
//                        print(response.response!) // HTTP URL response
//                        print(response.data!)     // server data
//                        print(response.result)   // result of response serialization
                        
                        print("Success! Got the routes")
                        let routesJSON : JSON = JSON(response.result.value!)
                        completion(routesJSON)
                    }
                    else {
                        print("Error \(String(describing: response.result.error))")
                    }
                })
                
            }
            else {
                print("Error \(String(describing: response.result.error))")
            }
        })
    }
}
