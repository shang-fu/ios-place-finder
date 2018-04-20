//
//  InfoViewController.swift
//  Place Finder
//
//  Created by Hsieh Shang-Fu on 4/18/18.
//  Copyright © 2018 Hsieh Shang-Fu. All rights reserved.
//

import UIKit
import SwiftyJSON

class InfoViewController: UIViewController {
//    let addressTextView: UITextView = {
//        let textView = UITextView()
//        textView.font = UIFont.boldSystemFont(ofSize: 18)
//        textView.translatesAutoresizingMaskIntoConstraints = false
//        textView.textAlignment = .center
//        textView.isEditable = false
//        textView.isScrollEnabled = false
//        return textView
//    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadJSON(detailJSON : JSON) {

        // address label
        let addressLabel = UILabel()
        view.addSubview(addressLabel)
        addressLabel.translatesAutoresizingMaskIntoConstraints = false
        addressLabel.text = "Address"
        addressLabel.font = UIFont.boldSystemFont(ofSize: 13)
        addressLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        addressLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        addressLabel.widthAnchor.constraint(equalToConstant: self.view.frame.width * 0.35).isActive = true
        addressLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        
        // address description
        let addressTextView = UITextView()
        view.addSubview(addressTextView)
        addressTextView.translatesAutoresizingMaskIntoConstraints = false
        addressTextView.isEditable = false
        addressTextView.isScrollEnabled = false
        addressTextView.sizeToFit()
        addressTextView.text = detailJSON["result"]["formatted_address"].stringValue
        addressTextView.font = UIFont.boldSystemFont(ofSize: 13)
//        addressTextView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
//        addressTextView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 20).isActive = true
//        addressTextView.textAlignment = .left
//        addressTextView.leftAnchor.constraint(equalTo: addressLabel.rightAnchor, constant: 20).isActive = true
        
//        addressTextView.widthAnchor.constraint(equalToConstant: self.view.frame.width * 0.6).isActive = true
//        addressTextView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        // phone label
        let phoneLabel = UILabel()
        view.addSubview(phoneLabel)
        phoneLabel.translatesAutoresizingMaskIntoConstraints = false
        phoneLabel.text = "Phone Number"
        phoneLabel.font = UIFont.boldSystemFont(ofSize: 13)
        phoneLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 150).isActive = true
        phoneLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        phoneLabel.widthAnchor.constraint(equalToConstant: self.view.frame.width * 0.35).isActive = true
        phoneLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        // phone description
        let phoneTextView = UITextView()
        view.addSubview(phoneTextView)
        phoneTextView.translatesAutoresizingMaskIntoConstraints = false
        phoneTextView.isEditable = false
        phoneTextView.isScrollEnabled = false
        phoneTextView.text = detailJSON["result"]["international_phone_number"].stringValue
//        phoneTextView.
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(InfoViewController.handleTap(_:)))
        
        phoneTextView.addGestureRecognizer(tap)
        
        phoneTextView.isUserInteractionEnabled = true
        
        
        
        
        
        
        phoneTextView.font = UIFont.boldSystemFont(ofSize: 13)
        phoneTextView.topAnchor.constraint(equalTo: view.topAnchor, constant: 150).isActive = true
        phoneTextView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 20).isActive = true
        phoneTextView.widthAnchor.constraint(equalToConstant: self.view.frame.width * 0.6).isActive = true
        phoneTextView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        // price label
        let priceLabel = UILabel()
        view.addSubview(priceLabel)
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.text = "Price Level"
        priceLabel.font = UIFont.boldSystemFont(ofSize: 13)
        priceLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 200).isActive = true
        priceLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        priceLabel.widthAnchor.constraint(equalToConstant: self.view.frame.width * 0.35).isActive = true
        priceLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        // price description
        let priceTextView = UITextView()
        view.addSubview(priceTextView)
        priceTextView.translatesAutoresizingMaskIntoConstraints = false
        priceTextView.isEditable = false
        priceTextView.isScrollEnabled = false
        let price = detailJSON["result"]["price_level"].stringValue
        if price == "1" {
            priceTextView.text = "$"
        } else if price == "2" {
            priceTextView.text = "$$"
        } else if price == "3" {
            priceTextView.text = "$$$"
        } else if price == "4" {
            priceTextView.text = "$$$$"
        }
        
        priceTextView.font = UIFont.boldSystemFont(ofSize: 13)
        priceTextView.topAnchor.constraint(equalTo: view.topAnchor, constant: 200).isActive = true
        priceTextView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 20).isActive = true
        priceTextView.widthAnchor.constraint(equalToConstant: self.view.frame.width * 0.6).isActive = true
        priceTextView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        
        // rating label
        let ratingLabel = UILabel()
        view.addSubview(ratingLabel)
        ratingLabel.translatesAutoresizingMaskIntoConstraints = false
        ratingLabel.text = "Rating"
        ratingLabel.font = UIFont.boldSystemFont(ofSize: 13)
        ratingLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 250).isActive = true
        ratingLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        ratingLabel.widthAnchor.constraint(equalToConstant: self.view.frame.width * 0.35).isActive = true
        ratingLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        // rating description
        let ratingTextView = UITextView()
        view.addSubview(ratingTextView)
        ratingTextView.translatesAutoresizingMaskIntoConstraints = false
        ratingTextView.isEditable = false
        ratingTextView.isScrollEnabled = false
//        ratingTextView.text = detailJSON["result"]["international_phone_number"].stringValue
        ratingTextView.font = UIFont.boldSystemFont(ofSize: 13)
        ratingTextView.topAnchor.constraint(equalTo: view.topAnchor, constant: 250).isActive = true
        ratingTextView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 20).isActive = true
        ratingTextView.widthAnchor.constraint(equalToConstant: self.view.frame.width * 0.6).isActive = true
        ratingTextView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        
        // website label
        let websiteLabel = UILabel()
        view.addSubview(websiteLabel)
        websiteLabel.translatesAutoresizingMaskIntoConstraints = false
        websiteLabel.text = "Website"
        websiteLabel.font = UIFont.boldSystemFont(ofSize: 13)
        websiteLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 300).isActive = true
        websiteLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        websiteLabel.widthAnchor.constraint(equalToConstant: self.view.frame.width * 0.35).isActive = true
        websiteLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        // website description
        let websiteTextView = UITextView()
        view.addSubview(websiteTextView)
        websiteTextView.translatesAutoresizingMaskIntoConstraints = false
        websiteTextView.isEditable = false
        websiteTextView.isScrollEnabled = false
        
        let attributedString = NSMutableAttributedString(string: detailJSON["result"]["website"].stringValue)
        attributedString.addAttribute(.link, value: detailJSON["result"]["website"].stringValue, range: NSRange())
        
        websiteTextView.attributedText = attributedString
        
        
        websiteTextView.font = UIFont.boldSystemFont(ofSize: 13)
        websiteTextView.topAnchor.constraint(equalTo: view.topAnchor, constant: 300).isActive = true
        websiteTextView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 20).isActive = true
        websiteTextView.widthAnchor.constraint(equalToConstant: self.view.frame.width * 0.6).isActive = true
        websiteTextView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
    }
    
    // function which is triggered when handleTap is called
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        print("Hello World")
    }
    
    


}
