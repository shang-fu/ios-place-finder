//
//  GoogleReviewViewController.swift
//  Place Finder
//
//  Created by Hsieh Shang-Fu on 4/21/18.
//  Copyright © 2018 Hsieh Shang-Fu. All rights reserved.
//

import UIKit
import SwiftyJSON

class GoogleReviewViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var detailJSON : JSON?
    var googleReviews = [GoogleReview]()
    private var myTableView: UITableView!


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
            let displayWidth: CGFloat = self.view.frame.width
            let displayHeight: CGFloat = self.view.frame.height
            
            myTableView = UITableView(frame: CGRect(x: 0, y: 0, width: displayWidth, height: displayHeight - 252))
            myTableView.register(UINib(nibName: "CustomReviewCell", bundle: nil), forCellReuseIdentifier: "customReviewCell")
            myTableView.dataSource = self
            myTableView.delegate = self
            self.view.addSubview(myTableView)
            
        }

    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print("Num: \(indexPath.row)")
//        print("Value: \(myArray[indexPath.row])")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return googleReviews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customReviewCell", for: indexPath) as! CustomReviewCell
        
        // adding name
        cell.name.text = "\(googleReviews[indexPath.row].name)"
        
        // adding rating star
        let ratingDouble = Double(googleReviews[indexPath.row].rating)
        if let ratingDouble = ratingDouble {
            cell.rating.rating = ratingDouble
        }
        
        // adding time
        let unixTimestamp = Double(googleReviews[indexPath.row].time)!
        let date = Date(timeIntervalSince1970: unixTimestamp)
        let dateFormatter = DateFormatter()
//        dateFormatter.timeZone = TimeZone(abbreviation: "GMT") //Set timezone that you want
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss" //Specify your format that you want
        let strDate = dateFormatter.string(from: date)
        cell.time.text = strDate
        
        // adding review
        cell.review.text = "\(googleReviews[indexPath.row].text)"
        return cell
    }

}
