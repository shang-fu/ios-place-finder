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

class DetailViewController: UITabBarController {
    var placeid = ""
    let searchPlaceDetail = SearchPlaceDetail()
    let heartFilled = UIImage(named: "favorite-filled")
    let heartEmpty  = UIImage(named: "favorite-empty")
    let arrowTwitter    = UIImage(named: "forward-arrow")

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let twitter   = UIBarButtonItem(image: arrowTwitter,  style: .plain, target: self, action: #selector(DetailViewController.didTapArrow(_:)))
        let heart = UIBarButtonItem(image: heartFilled,  style: .plain, target: self, action: #selector(DetailViewController.didTapHeart(_:)))
        
        navigationItem.rightBarButtonItems = [heart, twitter]
        
//        print(self.viewControllers!)
        
        getDetail()
    }
    
    @objc func didTapArrow(_ button:UIBarButtonItem!) {
        print("Arrow tapped")
    }
    
    @objc func didTapHeart(_ button:UIBarButtonItem!) {
        print("Heart tapped")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getDetail() {
        SwiftSpinner.show("Searching place detail...")
        
        searchPlaceDetail.placeid = self.placeid
        
        searchPlaceDetail.getDetail() { (detailJSON) in
            
            self.title = detailJSON["result"]["name"].stringValue
            
            let infoVC = self.viewControllers![0] as! InfoViewController
            infoVC.loadJSON(detailJSON : detailJSON)
            
            let photoVC = self.viewControllers![1] as! PhotoViewController
            photoVC.loadJSON(detailJSON : detailJSON)
            
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
