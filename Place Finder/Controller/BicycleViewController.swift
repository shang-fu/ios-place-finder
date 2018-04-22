//
//  BicycleViewController.swift
//  Place Finder
//
//  Created by Hsieh Shang-Fu on 4/21/18.
//  Copyright © 2018 Hsieh Shang-Fu. All rights reserved.
//

import UIKit
import GoogleMaps
import SwiftyJSON

class BicycleViewController: UIViewController {
    var lat : String = ""
    var lng : String = ""
    var markerTitle : String = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadMap() {
        // Create a GMSCameraPosition that tells the map to display the
        // coordinate -33.86,151.20 at zoom level 6.
        let camera = GMSCameraPosition.camera(withLatitude: Double(lat)!, longitude: Double(lng)!, zoom: 6.0)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        view = mapView
        
        // Creates a marker in the center of the map.
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: Double(lat)!, longitude: Double(lng)!)
        marker.title = markerTitle
        marker.map = mapView
    }

}
