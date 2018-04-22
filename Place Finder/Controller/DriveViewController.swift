//
//  DriveViewController.swift
//  Place Finder
//
//  Created by Hsieh Shang-Fu on 4/21/18.
//  Copyright © 2018 Hsieh Shang-Fu. All rights reserved.
//

import UIKit
import GoogleMaps
import SwiftyJSON

class DriveViewController: UIViewController {
    var destinationLat : String = ""
    var destinationLng : String = ""
    var destinationMarkerTitle : String = ""
    var originAddress : String = ""
    let searchRoutes = SearchRoutes()
    let mode : String = "driving"
    var mapView : GMSMapView?

    override func viewDidLoad() {
        super.viewDidLoad()
//        print(self.lat)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadMap() {
        // Create a GMSCameraPosition that tells the map to display the
        // coordinate -33.86,151.20 at zoom level 6.
        let camera = GMSCameraPosition.camera(withLatitude: Double(destinationLat)!, longitude: Double(destinationLng)!, zoom: 6.0)
        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        view = mapView
        
        // Creates a marker in the center of the map.
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: Double(destinationLat)!, longitude: Double(destinationLng)!)
        marker.title = destinationMarkerTitle
        marker.map = mapView
    }
    
    func findRoutes() {
        searchRoutes.originAddress = originAddress
        searchRoutes.destinationLat = destinationLat
        searchRoutes.destinationLng = destinationLng
        searchRoutes.mode = mode
        searchRoutes.findRoutes() { (routesJSON) in
            let routes = routesJSON["routes"].arrayValue
            
            for route in routes {
                let routeOverviewPolyline = route["overview_polyline"].dictionary
                let points = routeOverviewPolyline?["points"]?.stringValue
                let path = GMSPath.init(fromEncodedPath: points!)
                let polyline = GMSPolyline.init(path: path)
                polyline.strokeWidth = 2
                polyline.map = self.mapView
            }
        }
    }
    
    

}
