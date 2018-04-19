//
//  ResultViewController.swift
//  Place Finder
//
//  Created by Hsieh Shang-Fu on 4/16/18.
//  Copyright © 2018 Hsieh Shang-Fu. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SwiftSpinner
import EasyToast

class ResultViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, HeartButtonsDelegate {
    var indexes : [String : String]?
    var latLong : [String : String]?
    let searchPlaces = SearchPlaces()
    var placesData : [Place]?
    var placeid = ""
    
    @IBOutlet weak var resultTableView: UITableView!
    @IBOutlet var prevPageButton: UIButton!
    @IBOutlet var nextPageButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        
        
        resultTableView.delegate = self
        resultTableView.dataSource = self
        resultTableView.register(UINib(nibName: "PlaceCell", bundle: nil), forCellReuseIdentifier: "customPlaceCell")
        configureTableView()
        
        firstPage()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    func firstPage() {
        SwiftSpinner.show("Searching...")
        
        print("search start")
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

        // callback after the data has loaded
        searchPlaces.getFirstPage(parameters: parameters) { (placesData, hasNextPage, hasPrevPage) in
            self.placesData = placesData
            self.resultTableView.reloadData()
            self.checkNextPrevButton(hasNextPage: hasNextPage, hasPrevPage: hasPrevPage)
            
            // after reload table view, delay 0.5 second, and hide spinner
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                SwiftSpinner.hide()
            }
        }
        
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "customPlaceCell", for: indexPath) as! CustomPlaceCell
        
        if let placesData = self.placesData {
            cell.textView.text = "\(placesData[indexPath.row].name)\n\n\(placesData[indexPath.row].vicinity)"
            cell.icon.image = placesData[indexPath.row].icon

            cell.placeName = placesData[indexPath.row].name

            cell.delegate = self
            
            var isFav = false
            cell.isFav = isFav
            if (cell.isFav) {
                cell.heart.setBackgroundImage(UIImage(named: "favorite-filled"), for: UIControlState.normal)
            } else {
                cell.heart.setBackgroundImage(UIImage(named: "favorite-empty"), for: UIControlState.normal)
            }
            
        }
        
        return cell
    }
    
    func filledHeartTapped(placeName : String) {
        self.view.showToast("\(placeName) was removed from favorites", tag:"test", position: .bottom, popTime: kToastNoPopTime, dismissOnTap: false)
    }
    func emptyHeartTapped(placeName : String) {
        self.view.showToast("\(placeName) was added to favorites", tag:"test", position: .bottom, popTime: kToastNoPopTime, dismissOnTap: false)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let placesData = placesData {
            return placesData.count
        } else {
            return 0
        }
    }
    
    func configureTableView() {
        resultTableView.rowHeight = UITableViewAutomaticDimension
        resultTableView.estimatedRowHeight = 180.0
    }

    @IBAction func nextPageClicked(_ sender: UIButton) {
        print("next page button pressed...")
        nextPage()
    }
    
    @IBAction func prevPageClicked(_ sender: UIButton) {
        print("prev page button pressed...")
        prevPage()
    }
    
    func nextPage() {
//        SwiftSpinner.show("Loading next page...")
        
        searchPlaces.getNextPage() { (placesData, hasNextPage, hasPrevPage) in
            self.placesData = placesData
            self.resultTableView.reloadData()
            self.checkNextPrevButton(hasNextPage: hasNextPage, hasPrevPage: hasPrevPage)
            
            // after reload table view, delay 0.5 second, and hide spinner
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                SwiftSpinner.hide()
            }
        }
        
    }
    
    func prevPage() {
        searchPlaces.getPrevPage() { (placesData, hasNextPage, hasPrevPage) in
            self.placesData = placesData
            self.resultTableView.reloadData()
            self.checkNextPrevButton(hasNextPage: hasNextPage, hasPrevPage: hasPrevPage)
        }
    }
    
    func checkNextPrevButton(hasNextPage : Bool, hasPrevPage : Bool) {
        if (hasNextPage) {
            nextPageButton.isEnabled = true
        } else {
            nextPageButton.isEnabled = false
        }
        
        if (hasPrevPage) {
            prevPageButton.isEnabled = true
        } else {
            prevPageButton.isEnabled = false
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? CustomPlaceCell {
            self.placeid = placesData![indexPath.row].id
            performSegue(withIdentifier: "resultToDetailVC", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "resultToDetailVC" {
            let secondVC = segue.destination as! DetailViewController
            secondVC.placeid = self.placeid
        }
    }
    
    
}
