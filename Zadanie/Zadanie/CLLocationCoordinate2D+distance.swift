//
//  CLLocationCoordinate2D+distance.swift
//  Zadanie
//
//  Created by Adrian Kubała on 08.02.2017.
//  Copyright © 2017 Adrian. All rights reserved.
//

import CoreLocation

extension CLLocationCoordinate2D {
  func distanceInKMTo(_ location: CLLocationCoordinate2D) -> Double {
    let firstLocation = CLLocation(latitude: latitude, longitude: longitude)
    let secondLocation = CLLocation(latitude: location.latitude, longitude: location.longitude)
    
    let distance = secondLocation.distance(from: firstLocation) / 1000
    return Double(distance)
  }
}
