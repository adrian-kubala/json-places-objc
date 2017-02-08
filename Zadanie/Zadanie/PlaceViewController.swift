//
//  PlaceViewController.swift
//  Zadanie
//
//  Created by Adrian on 08.02.2017.
//  Copyright © 2016 Adrian. All rights reserved.
//

import UIKit
import GoogleMaps

class PlaceViewController: UIViewController {
  var mapLatitude: Double!
  var mapLongitude: Double!
  var mapPinImage: UIImage!
  var mapPinName: String!

  override func loadView() {
    let camera = GMSCameraPosition.camera(withLatitude: mapLatitude, longitude: mapLongitude, zoom: 16.0)
    let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
    mapView.isMyLocationEnabled = true
    view = mapView
    
    let marker = GMSMarker()
    marker.position = CLLocationCoordinate2D(latitude: mapLatitude, longitude: mapLongitude)
    
    marker.title = mapPinName
    marker.icon = mapPinImage
    marker.map = mapView
    mapView.selectedMarker = marker
  }
}
