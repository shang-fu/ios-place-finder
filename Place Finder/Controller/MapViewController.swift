//
//  MapViewController.swift
//  Place Finder
//
//  Created by Hsieh Shang-Fu on 4/18/18.
//  Copyright © 2018 Hsieh Shang-Fu. All rights reserved.
//

import UIKit
import SwiftyJSON
import GooglePlaces

class MapViewController: UIViewController {

    @IBOutlet weak var fromTextView: UITextField!
    @IBOutlet weak var driveView: UIView!
    @IBOutlet weak var bicycleView: UIView!
    @IBOutlet weak var transitView: UIView!
    @IBOutlet weak var walkView: UIView!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    var driveViewController : DriveViewController?
    
    var detailJSON : JSON?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.segmentControl.selectedSegmentIndex = 0
        self.bicycleView.alpha = 0
        self.transitView.alpha = 0
        self.walkView.alpha = 0
        self.driveView.alpha = 1
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadJSON(detailJSON : JSON) {
//        print(detailJSON["result"]["international_phone_number"].stringValue)
        self.detailJSON = detailJSON
    }
    
    
    @IBAction func travelModeChanged(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            UIView.animate(withDuration: 0.5, animations: {
                self.bicycleView.alpha = 0
                self.transitView.alpha = 0
                self.walkView.alpha = 0
                self.driveView.alpha = 1
            })
        } else if sender.selectedSegmentIndex == 1 {
            UIView.animate(withDuration: 0.5, animations: {
                self.transitView.alpha = 0
                self.walkView.alpha = 0
                self.driveView.alpha = 0
                self.bicycleView.alpha = 1
            })
        } else if sender.selectedSegmentIndex == 2 {
            UIView.animate(withDuration: 0.5, animations: {
                self.walkView.alpha = 0
                self.driveView.alpha = 0
                self.bicycleView.alpha = 0
                self.transitView.alpha = 1
            })
        } else if sender.selectedSegmentIndex == 3 {
            UIView.animate(withDuration: 0.5, animations: {
                self.driveView.alpha = 0
                self.bicycleView.alpha = 0
                self.transitView.alpha = 0
                self.walkView.alpha = 1
            })
        }
    }
    
    func findRoute() {
        
    }
    
    
    @IBAction func autocompleteClicked(_ sender: UITextField) {
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = self
        present(autocompleteController, animated: true, completion: nil)
//        if let driveViewController = self.driveViewController {
//            print("address before \(self.fromTextView.text!)")
//            driveViewController.originAddress = self.fromTextView.text!
//            driveViewController.findRoutes()
//        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "mapToDriveVC" {
//            let secondVC = segue.destination as! DriveViewController
//            if let detailJSON = self.detailJSON {
//                secondVC.destinationLat = detailJSON["result"]["geometry"]["location"]["lat"].stringValue
//                secondVC.destinationLng = detailJSON["result"]["geometry"]["location"]["lng"].stringValue
//                secondVC.destinationMarkerTitle = detailJSON["result"]["name"].stringValue
//                secondVC.originAddress = fromTextView.text!
//
//                print(detailJSON["result"]["geometry"]["location"]["lat"].stringValue)
//                secondVC.loadMap()
//            }
            
            driveViewController = segue.destination as? DriveViewController
            if let detailJSON = self.detailJSON {
                driveViewController!.destinationLat = detailJSON["result"]["geometry"]["location"]["lat"].stringValue
                driveViewController!.destinationLng = detailJSON["result"]["geometry"]["location"]["lng"].stringValue
                driveViewController!.destinationMarkerTitle = detailJSON["result"]["name"].stringValue
            
//                print(detailJSON["result"]["geometry"]["location"]["lat"].stringValue)
                driveViewController!.loadMap()
            }
            
        }
        
        if segue.identifier == "mapToBicycleVC" {
            let secondVC = segue.destination as! BicycleViewController
            if let detailJSON = self.detailJSON {
                secondVC.lat = detailJSON["result"]["geometry"]["location"]["lat"].stringValue
                secondVC.lng = detailJSON["result"]["geometry"]["location"]["lng"].stringValue
                secondVC.markerTitle = detailJSON["result"]["name"].stringValue
                print(detailJSON["result"]["geometry"]["location"]["lat"].stringValue)
                secondVC.loadMap()
            }
        }
    }
    
}


extension MapViewController: GMSAutocompleteViewControllerDelegate {
    
    // Handle the user's selection.
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        fromTextView.text = place.formattedAddress
        dismiss(animated: true, completion: nil)
        
        if let driveViewController = self.driveViewController {
            driveViewController.originAddress = self.fromTextView.text!
            driveViewController.findRoutes()
        }
        
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        // TODO: handle the error.
        print("Error: ", error.localizedDescription)
    }
    
    // User canceled the operation.
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    // Turn the network activity indicator on and off again.
    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
}
