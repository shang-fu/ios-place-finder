//
//  ResultViewController.swift
//  Place Finder
//
//  Created by Hsieh Shang-Fu on 4/16/18.
//  Copyright © 2018 Hsieh Shang-Fu. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
    var indexes : [String : String]?
    var latLong : [String : String]?
    
    let searchPlaces = SearchPlaces()

    @IBOutlet weak var labeltest: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//locale=other&keyword=pizza&type=restaurant&distance=10&lat=34&lng=-118&localeOtherDetail=new+york
        
        var parameters : [String : String] = [
            "keyword" : self.indexes!["keyword"]!,
            "lat" : self.latLong!["lat"]!,
            "lng" : self.latLong!["lng"]!,
            "localeOtherDetail" : self.indexes!["from"]!,
            ]
        if self.indexes!["distance"]! == "" {
            parameters["distance"] = "10"
        } else {
            parameters["distance"] = self.indexes!["distance"]!
        }
        if self.indexes!["from"]! == "Your location" {
            parameters["locale"] = "current"
        } else {
            parameters["locale"] = "other"
        }
        parameters["type"] = self.indexes!["category"]!.lowercased().replacingOccurrences(of: " ", with: "_")
//        print(self.indexes!)
        print(parameters)
        searchPlaces.getPlaces(parameters: parameters)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
