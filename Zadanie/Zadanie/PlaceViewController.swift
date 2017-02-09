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
  var place: Place!

  override func loadView() {
    let latitude = place.location.coordinate.latitude
    let longitude = place.location.coordinate.longitude
    
    let camera = GMSCameraPosition.camera(withLatitude: latitude, longitude: longitude, zoom: 16.0)
    let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
    mapView.isMyLocationEnabled = true
    view = mapView
    
    let marker = GMSMarker()
    marker.position = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    
    marker.title = place.name
    marker.icon = place.pinImage
    marker.map = mapView
    mapView.selectedMarker = marker
  }
}
