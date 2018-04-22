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
    var markers = [GMSMarker]()
    var polylines = [GMSPolyline]()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func loadMap() {
        // Create a GMSCameraPosition that tells the map to display the
        let camera = GMSCameraPosition.camera(withLatitude: Double(destinationLat)!, longitude: Double(destinationLng)!, zoom: 13)
        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        view = mapView
        
        // Creates a marker in the center of the map.
        let marker = GMSMarker()
        markers.append(marker)
        marker.position = CLLocationCoordinate2D(latitude: Double(destinationLat)!, longitude: Double(destinationLng)!)
        marker.title = destinationMarkerTitle
        marker.map = mapView
    }
    
    func findRoutes() {
        searchRoutes.originAddress = originAddress
        searchRoutes.destinationLat = destinationLat
        searchRoutes.destinationLng = destinationLng
        searchRoutes.mode = mode
        searchRoutes.findRoutes() { (routesJSON, originLat, originLng) in
            
            // delete previous markers
            if self.markers.count > 0 {
                for _ in 0...self.markers.count - 1 {
                    let marker = self.markers.removeLast()
                    marker.map = nil
                }
            }
            
            // re-add destination marker
            let destinationMarker = GMSMarker()
            self.markers.append(destinationMarker)
            destinationMarker.position = CLLocationCoordinate2D(latitude: Double(self.destinationLat)!, longitude: Double(self.destinationLng)!)
            destinationMarker.title = self.destinationMarkerTitle
            destinationMarker.map = self.mapView
            
            // add origin marker
            let originMarker = GMSMarker()
            self.markers.append(originMarker)
            originMarker.position = CLLocationCoordinate2D(latitude: Double(originLat)!, longitude: Double(originLng)!)
            originMarker.title = self.originAddress
            originMarker.map = self.mapView
            
            // delete previous routes
            if self.polylines.count > 0 {
                for _ in 0...self.polylines.count - 1 {
                    let polyline = self.polylines.removeLast()
                    polyline.map = nil
                }
            }
            
            // draw routes
            let routes = routesJSON["routes"].arrayValue
            for route in routes {
                let routeOverviewPolyline = route["overview_polyline"].dictionary
                let points = routeOverviewPolyline?["points"]?.stringValue
                let path = GMSPath.init(fromEncodedPath: points!)
                let polyline = GMSPolyline.init(path: path)
                polyline.strokeWidth = 2
                polyline.map = self.mapView
                self.polylines.append(polyline)
            }
            
            // re-zoom in the map to fit two markers
            var bounds = GMSCoordinateBounds()
            for marker in self.markers
            {
                bounds = bounds.includingCoordinate(marker.position)
            }
            let update = GMSCameraUpdate.fit(bounds, withPadding: 60)
            self.mapView!.animate(with: update)
        }
    }
}
