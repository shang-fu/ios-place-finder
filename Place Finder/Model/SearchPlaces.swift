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
import SwiftSpinner

class SearchPlaces {
    let url = "https://travel-entertain-search.appspot.com/search"
    var pageOne = [Place]()
    var pageTwo = [Place]()
    var pageThr = [Place]()
    var currentPage = [Place]()
    
    var currentPageNum : Int = 0
    var nextPageToken : String = ""
    var hasSecondPage : Bool = false
    var hasThirdPage : Bool = false
    
    func getFirstPage(parameters: [String: String], completion: @escaping ([Place], Bool, Bool) -> Void) {
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON(completionHandler:  {
            response -> Void in
            if response.result.isSuccess {
                
                print("Success! Got the places")
                let placesJSON : JSON = JSON(response.result.value!)
                let placesArray = placesJSON["results"].arrayValue
                if placesArray.count > 0 {
                    for index in 0...placesArray.count - 1 {
                        
                        let urlIcon = URL(string: placesArray[index]["icon"].stringValue)
                        let data = try? Data(contentsOf: urlIcon!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
                        let icon = UIImage(data: data!)
                        
                        let place = Place(id : placesArray[index]["place_id"].stringValue, name : placesArray[index]["name"].stringValue, icon : icon!, vicinity : placesArray[index]["vicinity"].stringValue)
                        self.pageOne.append(place)
                    }
                    
                    self.currentPage = self.pageOne
                    self.currentPageNum = 1
                    
                    self.nextPageToken = placesJSON["next_page_token"].stringValue
                    
                    if self.nextPageToken != "" {
                        self.hasSecondPage = true
                    } else {
                        self.hasSecondPage = false
                    }
                    
                    completion(self.currentPage, self.hasSecondPage, false)
                } else {
                    completion(self.currentPage, false, false)
                }
                

            }
            else {
                print("Error \(String(describing: response.result.error))")
                completion([], false, false)
            }
        })
    }
    
    func getNextPage(completion: @escaping ([Place], Bool, Bool) -> Void) {
        if (currentPageNum == 1) {
            if (pageTwo.count == 0) {
                SwiftSpinner.show("Loading next page...")
                requestNextPage() { (placesData, hasNextPage, hasPrevPage) in
                    completion(placesData, hasNextPage, hasPrevPage)
                }
            } else {
                self.currentPage = self.pageTwo
                self.currentPageNum = 2
                completion(self.currentPage, self.hasThirdPage, true)
            }
        } else if (currentPageNum == 2) {
            if (pageThr.count == 0) {
                SwiftSpinner.show("Loading next page...")
                requestNextPage() { (placesData, hasNextPage, hasPrevPage) in
                    completion(placesData, hasNextPage, hasPrevPage)
                }
            } else {
                self.currentPage = self.pageThr
                self.currentPageNum = 3
                completion(self.currentPage, false, true)
            }
        }
        
    }
    
    func requestNextPage(completion: @escaping ([Place], Bool, Bool) -> Void) {
        let parameters : [String : String] = ["pagetoken" : nextPageToken]
        
        
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON(completionHandler:  {
            response -> Void in
            if response.result.isSuccess {
                
                print("Success! Got the next page data...")
                let placesJSON : JSON = JSON(response.result.value!)
                let placesArray = placesJSON["results"].arrayValue
                
                for index in 0...placesArray.count - 1 {
                    
                    let urlIcon = URL(string: placesArray[index]["icon"].stringValue)
                    let data = try? Data(contentsOf: urlIcon!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
                    let icon = UIImage(data: data!)
                    
                    let place = Place(id : placesArray[index]["place_id"].stringValue, name : placesArray[index]["name"].stringValue, icon : icon!, vicinity : placesArray[index]["vicinity"].stringValue)
                    if (self.currentPageNum == 1) {
                        self.pageTwo.append(place)
                    } else if (self.currentPageNum == 2) {
                        self.pageThr.append(place)
                    }
                }
                
                self.nextPageToken = ""
                
                if (self.currentPageNum == 1) {
                    self.currentPage = self.pageTwo
                    self.currentPageNum = 2
                    
                    self.nextPageToken = placesJSON["next_page_token"].stringValue
                    
                    if self.nextPageToken != "" {
                        self.hasThirdPage = true
                    } else {
                        self.hasThirdPage = false
                    }
                    
                    completion(self.currentPage, self.hasThirdPage, true)
                } else if (self.currentPageNum == 2) {
                    self.currentPage = self.pageThr
                    self.currentPageNum = 3
                    
//                    self.nextPageToken = placesJSON["next_page_token"].stringValue
//
//                    if self.nextPageToken != nil {
//                        self.hasThirdPage = true
//                    } else {
//                        self.hasThirdPage = false
//                    }
                    completion(self.currentPage, false, true)
                }
                
            }
            else {
                print("Error \(String(describing: response.result.error))")
                completion([], false, false)
            }
        })
    }
    
    func getPrevPage(completion: @escaping ([Place], Bool, Bool) -> Void) {
        if (currentPageNum == 3) {
            self.currentPage = self.pageTwo
            self.currentPageNum = 2
            completion(self.currentPage, self.hasThirdPage, true)
        } else if (currentPageNum == 2) {
            self.currentPage = self.pageOne
            self.currentPageNum = 1
            completion(self.currentPage, self.hasSecondPage, false)
        }
    }
    
    
}
