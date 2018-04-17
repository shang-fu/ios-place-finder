//
//  SearchViewController.swift
//  Place Finder
//
//  Created by Hsieh Shang-Fu on 4/14/18.
//  Copyright © 2018 Hsieh Shang-Fu. All rights reserved.
//

import UIKit
import McPicker
import GooglePlaces
import EasyToast


protocol SearchIndexReceive {
    func searchIndexReceived(indexes: [String: String])
    func segueToNext(identifier: String)
}

class SearchViewController: UIViewController {
    
    var delegate : SearchIndexReceive?

    @IBOutlet weak var keywordTextField: UITextField!
    @IBOutlet weak var categoryTextField: McTextField!
    @IBOutlet weak var distanceTextField: UITextField!
    @IBOutlet weak var fromTextField: UITextField!
    
    let data: [[String]] = [
        ["Default", "Airport", "Amusement Park", "Aquarium", "Art Gallery", "Bakery", "Bar", "Beauty Salon", "Bowling Alley", "Bus Station", "Cafe", "Campground", "Car Rental", "Casino", "Lodging", "Movie Theater", "Museum", "Night Club", "Park", "Parking", "Restaurant", "Shopping Mall", "Stadium", "Subway Station", "Taxi Stand", "Train Station", "Transit Station", "Travel Agency", "Zoo"]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        categoryTextField.text = "Default"
        
        
        let mcInputView = McPicker(data: data)
        mcInputView.backgroundColorAlpha = 0.25
        categoryTextField.inputViewMcPicker = mcInputView
//        let originalText = categoryTextField.
        
        categoryTextField.doneHandler = { [weak categoryTextField] (selections) in
            categoryTextField?.text = selections[0]!
        }
        categoryTextField.selectionChangedHandler = { [weak categoryTextField] (selections, componentThatChanged) in
            categoryTextField?.text = selections[componentThatChanged]!
        }
        categoryTextField.cancelHandler = { [weak categoryTextField] in
//            categoryTextField?.text = "Cancelled."
        }
        categoryTextField.textFieldWillBeginEditingHandler = { [weak categoryTextField] (selections) in
            if categoryTextField?.text == "" {
                // Selections always default to the first value per component
                categoryTextField?.text = selections[0]
            }
        }
        
        

        

        
        
        
        distanceTextField.placeholder = "Enter distance (default 10 miles)"
        fromTextField.text = "Your location"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    

    @IBAction func autocompleteClicked(_ sender: UITextField) {
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = self
        present(autocompleteController, animated: true, completion: nil)
    }
    
    @IBAction func searchButtonClicked(_ sender: Any) {
        let keyword = keywordTextField.text!
        let isValid = keyword.range(of: ".*\\S+.*", options: .regularExpression) != nil
        if isValid {
            let indexes : [String : String] = ["keyword" : keywordTextField.text!, "category" : categoryTextField.text!, "distance" : distanceTextField.text!, "from" : fromTextField.text!]
            delegate?.searchIndexReceived(indexes: indexes)
            delegate?.segueToNext(identifier: "masterToResultVC")
            
        } else {
            view.showToast("Keyword cannot be empty", tag:"test", position: .bottom, popTime: kToastNoPopTime, dismissOnTap: false)
        }
    }
}

extension SearchViewController: GMSAutocompleteViewControllerDelegate {
    
    // Handle the user's selection.
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        fromTextField.text = place.formattedAddress
//        print("Place name: \(place.name)")
//        print("Place address: \(String(describing: place.formattedAddress))")
//        print("Place attributions: \(String(describing: place.attributions))")
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



