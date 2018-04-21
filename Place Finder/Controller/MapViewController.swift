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
        print(detailJSON["result"]["international_phone_number"].stringValue)
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
    
    @IBAction func autocompleteClicked(_ sender: UITextField) {
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = self
        present(autocompleteController, animated: true, completion: nil)
    }
}


extension MapViewController: GMSAutocompleteViewControllerDelegate {
    
    // Handle the user's selection.
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        fromTextView.text = place.formattedAddress
                print("Place name: \(place.name)")
                print("Place address: \(String(describing: place.formattedAddress))")
                print("Place attributions: \(String(describing: place.attributions))")
        dismiss(animated: true, completion: nil)
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
