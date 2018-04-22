//
//  ReviewViewController.swift
//  Place Finder
//
//  Created by Hsieh Shang-Fu on 4/18/18.
//  Copyright © 2018 Hsieh Shang-Fu. All rights reserved.
//

import UIKit
import SwiftyJSON

class ReviewViewController: UIViewController {

    @IBOutlet weak var googleReviewView: UIView!
    @IBOutlet weak var yelpReviewView: UIView!
    @IBOutlet weak var segmentForSwitchView: UISegmentedControl!
    @IBOutlet weak var segmentForSwitchSort: UISegmentedControl!
    @IBOutlet weak var segmentForSwitchOrder: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.segmentForSwitchView.selectedSegmentIndex = 0
        self.segmentForSwitchSort.selectedSegmentIndex = 0
        self.segmentForSwitchOrder.selectedSegmentIndex = 0
        self.yelpReviewView.alpha = 0
        self.googleReviewView.alpha = 1
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadJSON(detailJSON : JSON) {
        print(detailJSON["result"]["international_phone_number"].stringValue)
    }
    
    
    @IBAction func reviewSwitch(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            self.yelpReviewView.alpha = 0
            self.googleReviewView.alpha = 1
        } else if sender.selectedSegmentIndex == 1 {
            self.googleReviewView.alpha = 0
            self.yelpReviewView.alpha = 1
        }
    }
    
}
