//
//  DetailViewController.swift
//  Place Finder
//
//  Created by Hsieh Shang-Fu on 4/18/18.
//  Copyright © 2018 Hsieh Shang-Fu. All rights reserved.
//

import UIKit
import SwiftSpinner
import SwiftyJSON
import EasyToast

class DetailViewController: UITabBarController {
    var placeid = ""
    var primaryKey = ""
    var name = ""
    var iconUrl = ""
    var vicinity = ""
    let searchPlaceDetail = SearchPlaceDetail()
    let heartFilled = UIImage(named: "favorite-filled")
    let heartEmpty  = UIImage(named: "favorite-empty")
    let arrowTwitter    = UIImage(named: "forward-arrow")
    var detailJSON : JSON?
    let defaults = UserDefaults.standard
    var isFav = false
    var twitter: UIBarButtonItem?
    var heart: UIBarButtonItem?

    override func viewDidLoad() {
        super.viewDidLoad()
        twitter = UIBarButtonItem(image: arrowTwitter,  style: .plain, target: self, action: #selector(DetailViewController.didTapArrow(_:)))
        

        if defaults.dictionary(forKey: primaryKey) != nil{
            isFav = true
            heart = UIBarButtonItem(image: heartFilled,  style: .plain, target: self, action: #selector(DetailViewController.didTapHeart(_:)))
        } else {
            heart = UIBarButtonItem(image: heartEmpty,  style: .plain, target: self, action: #selector(DetailViewController.didTapHeart(_:)))
        }
        navigationItem.rightBarButtonItems = [heart!, twitter!]
        getDetail()
    }
    
    @objc func didTapArrow(_ button:UIBarButtonItem!) {
        print("Arrow tapped")
        
        var originalString = "https://twitter.com/intent/tweet?text=Check out \(detailJSON!["result"]["name"].stringValue) located at \(detailJSON!["result"]["formatted_address"].stringValue). Website: "
        if detailJSON!["result"]["website"].stringValue != "" {
            originalString += "&url=\(detailJSON!["result"]["website"].stringValue)"
        } else {
            originalString += "&url=\(detailJSON!["result"]["url"].stringValue)"
        }
        originalString += "&hashtags=TravelAndEntertainmentSearch"
        
        let escapedString = originalString.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed)

        guard let url = URL(string: escapedString!) else {
            return //be safe
        }
        
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
    
    @objc func didTapHeart(_ button:UIBarButtonItem!) {
        print("Heart tapped")
        
        if isFav {
            // de-favorite
            defaults.removeObject(forKey: self.primaryKey)
            isFav = false
            heart!.image = heartEmpty
            self.view.showToast("\(self.name) was removed from favorites", tag:"test", position: .bottom, popTime: kToastNoPopTime, dismissOnTap: false)
        } else {
            // add to favorite

            let dictionary = [
                "primaryKey" : self.primaryKey,
                "id" : self.placeid,
                "name" : self.name,
                "iconUrl" : self.iconUrl,
                "vicinity" : self.vicinity,
                "time" : String(NSDate().timeIntervalSince1970)
            ]
            defaults.set(dictionary, forKey: self.primaryKey)
            isFav = true
            heart!.image = heartFilled
            self.view.showToast("\(self.name) was added to favorites", tag:"test", position: .bottom, popTime: kToastNoPopTime, dismissOnTap: false)
            

            
        }
        
        
    }

    
    func getDetail() {
        SwiftSpinner.show("Searching place detail...")
        
        searchPlaceDetail.placeid = self.placeid
        
        searchPlaceDetail.getDetail() { (detailJSON) in
            self.detailJSON = detailJSON
            
            self.title = detailJSON["result"]["name"].stringValue
            
            let infoVC = self.viewControllers![0] as! InfoViewController
            infoVC.loadJSON(detailJSON : detailJSON)
            
            let photoVC = self.viewControllers![1] as! PhotoViewController
//            photoVC.loadJSON(detailJSON : detailJSON)
            photoVC.loadPlaceid(placeid: self.placeid)
            
            let mapVC = self.viewControllers![2] as! MapViewController
            mapVC.loadJSON(detailJSON : detailJSON)
            
            let reviewVC = self.viewControllers![3] as! ReviewViewController
            reviewVC.loadJSON(detailJSON : detailJSON)
            
            // after reload table view, delay 0.5 second, and hide spinner
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                SwiftSpinner.hide()
            }
        }
    }
    

}
