//
//  ViewController.swift
//  Place Finder
//
//  Created by Hsieh Shang-Fu on 4/14/18.
//  Copyright © 2018 Hsieh Shang-Fu. All rights reserved.
//

import UIKit
import CoreLocation

class MasterViewController: UIViewController, CLLocationManagerDelegate, SearchIndexReceive, ResultToMasterFavorite {
    
    let locationManager = CLLocationManager()
    var indexes : [String : String]?
    var latLong : [String : String]?
    
    var favoriteViewController : FavoriteViewController?

    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var favoriteView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func switchViewAction(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            UIView.animate(withDuration: 0.5, animations: {
                self.searchView.alpha = 1
                self.favoriteView.alpha = 0
            })
        } else {
            updateFavorites()
            UIView.animate(withDuration: 0.5, animations: {
                self.searchView.alpha = 0
                self.favoriteView.alpha = 1
            })
        }
    }
    
    // grab user current location
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[locations.count - 1]
        if location.horizontalAccuracy > 0 {
            locationManager.stopUpdatingLocation()
            print("\(location.coordinate.latitude), \(location.coordinate.longitude)")
            
            let longitude = String(location.coordinate.longitude)
            let latitude = String(location.coordinate.latitude)
            
            latLong = ["lat" : latitude, "lng" : longitude]
        }
    }
    
    // fail to grab user location
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "masterToSearchVC" {
            let secondVC = segue.destination as! SearchViewController
            secondVC.delegate = self
        }
        
        if segue.identifier == "masterToResultVC" {
            let secondVC = segue.destination as! ResultViewController
            secondVC.latLong = self.latLong
            secondVC.indexes = self.indexes
            secondVC.delegateFavorite = self
        }
        
        if segue.identifier == "masterToFavoriteVC" {
            favoriteViewController = segue.destination as? FavoriteViewController
        }
        
        
    }
    
    func searchIndexReceived(indexes: [String: String]) {
        self.indexes =  indexes
    }
    
    func segueToNext(identifier: String) {
        performSegue(withIdentifier: "masterToResultVC", sender: self)
    }
    
    func updateFavorites() {
        favoriteViewController?.updateFavorites()
    }
    
    
    
}

