//
//  NearbyPlacesViewController.swift
//  JSONPlaces
//
//  Created by Adrian on 11.08.2016.
//  Copyright © 2016 Adrian. All rights reserved.
//

import UIKit

class NearbyPlacesViewController: UITableViewController {
  var nearbyPlaces: [Place] = []
  
  override func viewDidLoad() {
    addLongPressGestureRecognizer(with: #selector(showPlaceDetails(recognizer:)))
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return nearbyPlaces.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "NearbyPlaceView", for: indexPath) as! PlaceView
    
    cell.pinImageView.image = nearbyPlaces[indexPath.row].pinImage
    cell.label.text = nearbyPlaces[indexPath.row].name
    
    return cell
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    let placeViewController = segue.destination as! PlaceViewController
    let cell = sender as! UITableViewCell
    let row = tableView.indexPath(for: cell)!.row
    placeViewController.place = nearbyPlaces[row]
  }
  
  func showPlaceDetails(recognizer: UIGestureRecognizer) {
    if recognizer.state == UIGestureRecognizerState.began {
      let swipeLocation = recognizer.location(in: tableView)
      if let swipedIndexPath = tableView.indexPathForRow(at: swipeLocation) {
        let location = nearbyPlaces[swipedIndexPath.row].location
        let latitude = location?.coordinate.latitude
        let longitude = location?.coordinate.longitude
        let distance = nearbyPlaces[swipedIndexPath.row].distance
        
        let alert = UIAlertController(title: "Współrzędne",
                                      message: "Szerokość: \(latitude)\nDługość: \(longitude)\nOdległość: \(String(format:"%.2f", distance)) km",
          preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        present(alert, animated: true, completion: nil)
      }
    }
  }
}
