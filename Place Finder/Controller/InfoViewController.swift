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


    @IBOutlet weak var addressDescription: UILabel!
    @IBOutlet weak var phoneDescription: UILabel!
    @IBOutlet weak var priceDescription: UILabel!
    @IBOutlet weak var ratingDescription: CosmosView!
    @IBOutlet weak var websiteDescription: UILabel!
    @IBOutlet weak var googlePageDescription: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

    
    func loadJSON(detailJSON : JSON) {
        
        //adding address
        if detailJSON["result"]["formatted_address"].stringValue != "" {
            addressDescription.text = detailJSON["result"]["formatted_address"].stringValue
            
        } else {
            addressDescription.text = "No Address Provided"
            addressDescription.textColor = UIColor.lightGray
        }
        
        //adding phone number
        if detailJSON["result"]["international_phone_number"].stringValue != "" {
            phoneDescription.text = detailJSON["result"]["international_phone_number"].stringValue
            phoneDescription.textColor = UIColor.blue
            phoneDescription.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(phoneClicked(_:))))
        } else {
            phoneDescription.text = "No Photo Number Provided"
            phoneDescription.textColor = UIColor.lightGray
        }
        
        // adding price level
        if detailJSON["result"]["price_level"].stringValue != "" {
            let price = detailJSON["result"]["price_level"].stringValue
            if price == "1" {
                priceDescription.text = "$"
            } else if price == "2" {
                priceDescription.text = "$$"
            } else if price == "3" {
                priceDescription.text = "$$$"
            } else if price == "4" {
                priceDescription.text = "$$$$"
            }
        } else {
            priceDescription.text = "No Price Level Provided"
            priceDescription.textColor = UIColor.lightGray
        }
        
        //adding rating
        if detailJSON["result"]["rating"].stringValue != "" {
            ratingDescription.rating = Double(detailJSON["result"]["rating"].stringValue)!
        } else {
            ratingDescription.rating = 0
        }
        
        //adding website
        if detailJSON["result"]["website"].stringValue != "" {
            websiteDescription.text = detailJSON["result"]["website"].stringValue
            websiteDescription.textColor = UIColor.blue
            websiteDescription.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(websiteClicked(_:))))
        } else {
            websiteDescription.text = "No Website"
            websiteDescription.textColor = UIColor.lightGray
        }
        
        //adding google page
        if detailJSON["result"]["url"].stringValue != "" {
            googlePageDescription.text = detailJSON["result"]["url"].stringValue
            googlePageDescription.textColor = UIColor.blue
            googlePageDescription.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(googlePageClicked(_:))))
        } else {
            googlePageDescription.text = "No Google Page"
            googlePageDescription.textColor = UIColor.lightGray
        }
        
    }
    
    @objc func websiteClicked(_ recognizer: UITapGestureRecognizer) {
        guard let url = URL(string: websiteDescription.text!) else {
            return //be safe
        }
        
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
    
    @objc func googlePageClicked(_ recognizer: UITapGestureRecognizer) {
        guard let url = URL(string: googlePageDescription.text!) else {
            return //be safe
        }
        
        print(url)
        
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
    
    @objc func phoneClicked(_ recognizer: UITapGestureRecognizer) {
        let formattedPhoneNumber = phoneDescription.text!.components(separatedBy: CharacterSet.decimalDigits.inverted).joined(separator: "")
        
        guard let url = URL(string: "sms://\(formattedPhoneNumber)") else {
            return //be safe
        }
        
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
    
    

}

extension UITapGestureRecognizer {
    func didTapAttributedTextInLabel(label: UILabel, inRange targetRange: NSRange) -> Bool {
        guard let attrString = label.attributedText else {
            return false
        }
        
        let layoutManager = NSLayoutManager()
        let textContainer = NSTextContainer(size: .zero)
        let textStorage = NSTextStorage(attributedString: attrString)
        
        layoutManager.addTextContainer(textContainer)
        textStorage.addLayoutManager(layoutManager)
        
        textContainer.lineFragmentPadding = 0
        textContainer.lineBreakMode = label.lineBreakMode
        textContainer.maximumNumberOfLines = label.numberOfLines
        let labelSize = label.bounds.size
        textContainer.size = labelSize
        
        let locationOfTouchInLabel = self.location(in: label)
        let textBoundingBox = layoutManager.usedRect(for: textContainer)
        let textContainerOffset = CGPoint(x: (labelSize.width - textBoundingBox.size.width) * 0.5 - textBoundingBox.origin.x, y: (labelSize.height - textBoundingBox.size.height) * 0.5 - textBoundingBox.origin.y)
        let locationOfTouchInTextContainer = CGPoint(x: locationOfTouchInLabel.x - textContainerOffset.x, y: locationOfTouchInLabel.y - textContainerOffset.y)
        let indexOfCharacter = layoutManager.characterIndex(for: locationOfTouchInTextContainer, in: textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
        return NSLocationInRange(indexOfCharacter, targetRange)
    }
}
