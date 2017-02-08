//
//  NearbyPlacesViewController.swift
//  Zadanie
//
//  Created by Adrian on 11.08.2016.
//  Copyright © 2016 Adrian. All rights reserved.
//

import UIKit

class NearbyPlacesViewController: UITableViewController {
  var nearbyPlaces: [Place] = []
  
  var reuseIdentifier = "placesTableCell"
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return nearbyPlaces.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! PlaceView
    
    cell.pinImageView.image = nearbyPlaces[indexPath.row].pinImage
    cell.label.text = nearbyPlaces[indexPath.row].name
    
    return cell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    let location = nearbyPlaces[indexPath.row].coordinates
    let latitude = location.coordinate.latitude
    let longitude = location.coordinate.longitude
    let distance = nearbyPlaces[indexPath.row].distance!
    
    let alert = UIAlertController(title: "Współrzędne", message: "Szerokość: \(latitude)\nDługość: \(longitude)\nOdległość: \(String(format:"%.2f", distance)) km", preferredStyle: UIAlertControllerStyle.alert)
    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
    self.present(alert, animated: true, completion: nil)
  }
}
