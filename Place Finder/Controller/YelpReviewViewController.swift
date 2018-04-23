//
//  YelpReviewViewController.swift
//  Place Finder
//
//  Created by Hsieh Shang-Fu on 4/21/18.
//  Copyright © 2018 Hsieh Shang-Fu. All rights reserved.
//

import UIKit
import SwiftyJSON

class YelpReviewViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var detailJSON : JSON?
    var yelpReviews = [YelpReview]()
    var defaultYelpReviews = [YelpReview]()
    var myTableView: UITableView!
    var yelpReviewsRequest = YelpReviewsRequest()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        yelpReviewsRequest.getReviews(
            name: detailJSON!["result"]["name"].stringValue,
            address: detailJSON!["result"]["formatted_address"].stringValue) { (yelpReviewsJSON) in
                self.showReviews(yelpReviewsJSON: yelpReviewsJSON)
            }
    }

    
    func showReviews(yelpReviewsJSON: JSON) {

        let reviews = yelpReviewsJSON["reviews"].arrayValue
        for review in reviews {
            let yelpReview = YelpReview(
                name: review["user"]["name"].stringValue,
                url: review["url"].stringValue,
                photo: review["user"]["image_url"].stringValue,
                rating: review["rating"].stringValue,
                text: review["text"].stringValue,
                time: review["time_created"].stringValue
            )
            yelpReviews.append(yelpReview)
            defaultYelpReviews.append(yelpReview)
        }
        
        if yelpReviews.count == 0 {
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
            
            myTableView = UITableView(frame: CGRect(x: 0, y: 0, width: displayWidth, height: displayHeight))
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
        guard let url = URL(string: yelpReviews[indexPath.row].url) else {
            return //be safe
        }
        
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return yelpReviews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customReviewCell", for: indexPath) as! CustomReviewCell
        
        // adding author photo
        let url = URL(string: yelpReviews[indexPath.row].photo)
        if let url = url {
            let data = try? Data(contentsOf: url) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
            cell.photo.image = UIImage(data: data!)
            cell.photo.layer.masksToBounds = true
            cell.photo.layer.cornerRadius = 35
        }
        
        
        // adding name
        cell.name.text = "\(yelpReviews[indexPath.row].name)"
        
        // adding rating star
        let ratingDouble = Double(yelpReviews[indexPath.row].rating)
        if let ratingDouble = ratingDouble {
            cell.rating.rating = ratingDouble
        }
        
        // adding time
        cell.time.text = yelpReviews[indexPath.row].time
        
        // adding review
        cell.review.text = "\(yelpReviews[indexPath.row].text)"
        return cell
    }



}
