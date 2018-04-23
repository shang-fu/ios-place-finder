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
    
    var detailJSON : JSON?
    var googleReviewViewController : GoogleReviewViewController?
    var yelpReviewViewController : YelpReviewViewController?
    
    
    
    
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
        self.detailJSON = detailJSON
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "reviewToGoogleVC" {
            googleReviewViewController = segue.destination as? GoogleReviewViewController
            if let googleReviewViewController = googleReviewViewController {
                googleReviewViewController.detailJSON = self.detailJSON
            }
            
        }
        if segue.identifier == "reviewToYelpVC" {
            yelpReviewViewController = segue.destination as? YelpReviewViewController

        }
        
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
    
    
    @IBAction func sortSwitch(_ sender: UISegmentedControl) {
        googleSort()
        yelpSort()
    }
    
    @IBAction func orderSwitch(_ sender: UISegmentedControl) {
        googleSort()
        yelpSort()
    }
    
    func googleSort() {
        if segmentForSwitchSort.selectedSegmentIndex == 0 {
            googleReviewViewController!.googleReviews = googleReviewViewController!.defaultGoogleReviews
            googleReviewViewController!.myTableView.reloadData()
        } else if segmentForSwitchSort.selectedSegmentIndex == 1 && segmentForSwitchOrder.selectedSegmentIndex == 0{
            googleReviewViewController!.googleReviews = googleReviewViewController!.googleReviews.sorted(by: { (review1: GoogleReview, review2: GoogleReview) -> Bool in
                return review1.rating < review2.rating
            })
            googleReviewViewController!.myTableView.reloadData()
        } else if segmentForSwitchSort.selectedSegmentIndex == 2 && segmentForSwitchOrder.selectedSegmentIndex == 0{
            googleReviewViewController!.googleReviews = googleReviewViewController!.googleReviews.sorted(by: { (review1: GoogleReview, review2: GoogleReview) -> Bool in
                return review1.time < review2.time
            })
            googleReviewViewController!.myTableView.reloadData()
        } else if segmentForSwitchSort.selectedSegmentIndex == 1 && segmentForSwitchOrder.selectedSegmentIndex == 1{
            googleReviewViewController!.googleReviews = googleReviewViewController!.googleReviews.sorted(by: { (review1: GoogleReview, review2: GoogleReview) -> Bool in
                return review1.rating > review2.rating
            })
            googleReviewViewController!.myTableView.reloadData()
        } else if segmentForSwitchSort.selectedSegmentIndex == 2 && segmentForSwitchOrder.selectedSegmentIndex == 1{
            googleReviewViewController!.googleReviews = googleReviewViewController!.googleReviews.sorted(by: { (review1: GoogleReview, review2: GoogleReview) -> Bool in
                return review1.time > review2.time
            })
            googleReviewViewController!.myTableView.reloadData()
        }
    }
    
    func yelpSort() {
        
    }
}
