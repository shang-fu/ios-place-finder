//
//  ResultViewController.swift
//  Place Finder
//
//  Created by Hsieh Shang-Fu on 4/16/18.
//  Copyright © 2018 Hsieh Shang-Fu. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var indexes : [String : String]?
    var latLong : [String : String]?
    
    @IBOutlet weak var resultTableView: UITableView!
    
    let searchPlaces = SearchPlaces()


    
    override func viewDidLoad() {
        super.viewDidLoad()
        resultTableView.delegate = self
        resultTableView.dataSource = self
        
        
        
        
        resultTableView.register(UINib(nibName: "PlaceCell", bundle: nil), forCellReuseIdentifier: "customPlaceCell")
        configureTableView()
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    func firstPage() {
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
//        print(parameters)
        searchPlaces.getPlaces(parameters: parameters)
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customPlaceCell", for: indexPath) as! CustomPlaceCell
        
        let message = ["A", "B", "C"] //
        
//        cell.messageBody.text = message[indexPath.row] //
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func configureTableView() {
        resultTableView.rowHeight = UITableViewAutomaticDimension
        resultTableView.estimatedRowHeight = 120.0
    }

}
