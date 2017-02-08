//
//  CLLocationCoordinate2D+distance.swift
//  Zadanie
//
//  Created by Adrian Kubała on 08.02.2017.
//  Copyright © 2017 Adrian. All rights reserved.
//

import CoreLocation

extension CLLocation {
  func distanceInKMTo(_ location: CLLocation) -> Double {
    let distance = location.distance(from: self) / 1000
    return Double(distance)
  }
}
