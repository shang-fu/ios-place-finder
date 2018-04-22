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
    var bicycleViewController : BicycleViewController?
    var transitViewController : TransitViewController?
    var walkViewController : WalkViewController?
    
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
        self.detailJSON = detailJSON
    }
    
    
    @IBAction func travelModeChanged(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            UIView.animate(withDuration: 1, animations: {
                self.bicycleView.alpha = 0
                self.transitView.alpha = 0
                self.walkView.alpha = 0
                self.driveView.alpha = 1
                
                // if the from text is not empty, then draw routes
                if self.fromTextView.text! != "" {
                    if let driveViewController = self.driveViewController {
                        driveViewController.originAddress = self.fromTextView.text!
                        driveViewController.findRoutes()
                    }
                }
            })
        } else if sender.selectedSegmentIndex == 1 {
            UIView.animate(withDuration: 1, animations: {
                self.transitView.alpha = 0
                self.walkView.alpha = 0
                self.driveView.alpha = 0
                self.bicycleView.alpha = 1
                
                // if the from text is not empty, then draw routes
                if self.fromTextView.text! != "" {
                    if let bicycleViewController = self.bicycleViewController {
                        bicycleViewController.originAddress = self.fromTextView.text!
                        bicycleViewController.findRoutes()
                    }
                }
            })
        } else if sender.selectedSegmentIndex == 2 {
            UIView.animate(withDuration: 1, animations: {
                self.walkView.alpha = 0
                self.driveView.alpha = 0
                self.bicycleView.alpha = 0
                self.transitView.alpha = 1
                
                // if the from text is not empty, then draw routes
                if self.fromTextView.text! != "" {
                    if let transitViewController = self.transitViewController {
                        transitViewController.originAddress = self.fromTextView.text!
                        transitViewController.findRoutes()
                    }
                }
            })
        } else if sender.selectedSegmentIndex == 3 {
            UIView.animate(withDuration: 1, animations: {
                self.driveView.alpha = 0
                self.bicycleView.alpha = 0
                self.transitView.alpha = 0
                self.walkView.alpha = 1
                
                // if the from text is not empty, then draw routes
                if self.fromTextView.text! != "" {
                    if let walkViewController = self.walkViewController {
                        walkViewController.originAddress = self.fromTextView.text!
                        walkViewController.findRoutes()
                    }
                }
            })
        }
    }
    
    func findRoute() {
        
    }
    
    
    @IBAction func autocompleteClicked(_ sender: UITextField) {
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = self
        present(autocompleteController, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "mapToDriveVC" {
            driveViewController = segue.destination as? DriveViewController
            if let detailJSON = self.detailJSON {
                driveViewController!.destinationLat = detailJSON["result"]["geometry"]["location"]["lat"].stringValue
                driveViewController!.destinationLng = detailJSON["result"]["geometry"]["location"]["lng"].stringValue
                driveViewController!.destinationMarkerTitle = detailJSON["result"]["name"].stringValue
                driveViewController!.loadMap()
            }
        }
        if segue.identifier == "mapToBicycleVC" {
            bicycleViewController = segue.destination as? BicycleViewController
            if let detailJSON = self.detailJSON {
                bicycleViewController!.destinationLat = detailJSON["result"]["geometry"]["location"]["lat"].stringValue
                bicycleViewController!.destinationLng = detailJSON["result"]["geometry"]["location"]["lng"].stringValue
                bicycleViewController!.destinationMarkerTitle = detailJSON["result"]["name"].stringValue
                bicycleViewController!.loadMap()
            }
        }
        if segue.identifier == "mapToTransitVC" {
            transitViewController = segue.destination as? TransitViewController
            if let detailJSON = self.detailJSON {
                transitViewController!.destinationLat = detailJSON["result"]["geometry"]["location"]["lat"].stringValue
                transitViewController!.destinationLng = detailJSON["result"]["geometry"]["location"]["lng"].stringValue
                transitViewController!.destinationMarkerTitle = detailJSON["result"]["name"].stringValue
                transitViewController!.loadMap()
            }
        }
        if segue.identifier == "mapToWalkVC" {
            walkViewController = segue.destination as? WalkViewController
            if let detailJSON = self.detailJSON {
                walkViewController!.destinationLat = detailJSON["result"]["geometry"]["location"]["lat"].stringValue
                walkViewController!.destinationLng = detailJSON["result"]["geometry"]["location"]["lng"].stringValue
                walkViewController!.destinationMarkerTitle = detailJSON["result"]["name"].stringValue
                walkViewController!.loadMap()
            }
        }
    }
}


extension MapViewController: GMSAutocompleteViewControllerDelegate {
    
    // Handle the user's selection.
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        fromTextView.text = place.formattedAddress
        dismiss(animated: true, completion: nil)
        
        if segmentControl.selectedSegmentIndex == 0 {
            if let driveViewController = self.driveViewController {
                driveViewController.originAddress = self.fromTextView.text!
                driveViewController.findRoutes()
            }
        } else if segmentControl.selectedSegmentIndex == 1 {
            if let bicycleViewController = self.bicycleViewController {
                bicycleViewController.originAddress = self.fromTextView.text!
                bicycleViewController.findRoutes()
            }
        } else if segmentControl.selectedSegmentIndex == 2 {
            if let transitViewController = self.transitViewController {
                transitViewController.originAddress = self.fromTextView.text!
                transitViewController.findRoutes()
            }
        } else if segmentControl.selectedSegmentIndex == 3 {
            if let walkViewController = self.walkViewController {
                walkViewController.originAddress = self.fromTextView.text!
                walkViewController.findRoutes()
            }
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
