//
//  GoogleReviewViewController.swift
//  Place Finder
//
//  Created by Hsieh Shang-Fu on 4/21/18.
//  Copyright © 2018 Hsieh Shang-Fu. All rights reserved.
//

import UIKit
import SwiftyJSON

class GoogleReviewViewController: UIViewController {
    var detailJSON : JSON?
    var googleReviews = [GoogleReview]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        showReviews()
        // Do any additional setup after loading the view.
    }
    
    func showReviews() {
//        print(detailJSON["result"]["international_phone_number"].stringValue)
        if let detailJSON = detailJSON {
            let reviews = detailJSON["result"]["reviews"].arrayValue
            for review in reviews {
                let googleReview = GoogleReview(name: review["author_name"].stringValue, url: review["author_url"].stringValue, photo: review["profile_photo_url"].stringValue, rating: review["rating"].stringValue,  text: review["text"].stringValue, time: review["time"].stringValue)
                googleReviews.append(googleReview)
            }
        }
        
        if googleReviews.count == 0 {
            let reviewLabel = UILabel()
            view.addSubview(reviewLabel)
            reviewLabel.translatesAutoresizingMaskIntoConstraints = false
            reviewLabel.text = "No Reviews"
            reviewLabel.font = UIFont.boldSystemFont(ofSize: 13)
            reviewLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            reviewLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
            reviewLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
            reviewLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        } else {
            
        }
        
        
        
        
        
        
    }

}
