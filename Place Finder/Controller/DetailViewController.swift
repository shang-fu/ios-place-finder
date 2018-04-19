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

    override func viewDidLoad() {
        super.viewDidLoad()

        getDetail()
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
            
            // after reload table view, delay 0.5 second, and hide spinner
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                SwiftSpinner.hide()
            }
        }
    }
    

}
