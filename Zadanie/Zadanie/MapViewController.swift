//
//  MapViewController.swift
//  Zadanie
//
//  Created by Adrian on 10.08.2016.
//  Copyright © 2016 Adrian. All rights reserved.
//

import UIKit
import GoogleMaps

class MapViewController: UIViewController {
    
    var mapLatitude: Double!
    var mapLongitude: Double!
    var mapPinImage: UIImage!
    var mapPinName: String!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func loadView() {
        // Create a GMSCameraPosition that tells the map to display the
        // coordinate -33.86,151.20 at zoom level 6.
        let camera = GMSCameraPosition.cameraWithLatitude(mapLatitude, longitude: mapLongitude, zoom: 16.0)
        let mapView = GMSMapView.mapWithFrame(CGRect.zero, camera: camera)
        mapView.myLocationEnabled = true
        view = mapView
        
        // Creates a marker in the center of the map.
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: mapLatitude, longitude: mapLongitude)
        
        marker.title = mapPinName
        marker.icon = mapPinImage
        marker.map = mapView
        mapView.selectedMarker = marker
    }
}