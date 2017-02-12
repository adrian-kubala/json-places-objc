//
//  PlacesViewController.swift
//  JSONPlaces
//
//  Created by Adrian on 09.08.2016.
//  Copyright © 2016 Adrian. All rights reserved.
//

import UIKit

class PlacesViewController: UITableViewController {
  var places: [Place] = []
  var matchedPlaces: [Place] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let jsonURL = URL(string: "http://pastebin.com/raw/dTYu3jmN")
    
    let jsonParser = JSONParser(url: jsonURL!)
    jsonParser?.fetch { [weak self] (result, error) in
      if let error = error {
        print(error.localizedDescription)
        return
      }
      
      if let result = result {
        self?.fillPlacesWithJSON(result)
      }
    }
  }
  
  func fillPlacesWithJSON(_ jsonArray: [Any]) {
    for object in jsonArray {
      let entry = object as! [String: Any]
      
      let name = entry["name"] as! String
      let imageURL = NSURL(string: entry["pin_url"] as! String)
      
      let coordinate = entry["coordinate"] as! [String: String]
      let lat = Double(coordinate["latitude"]!)
      let lon = Double(coordinate["longitude"]!)
      
      imageURL?.getImage { (image) in
        image?.resize(withNewWidth: 30) { (scaledImage) in
          
          let place = Place(name: name, latitude: lat!, longitude: lon!, pinImage: scaledImage)
          self.places.append(place!)
          
          self.tableView.reloadData()
        }  
      }
    }
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return places.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "PlaceView", for: indexPath) as! PlaceView
    
    cell.label.text = places[indexPath.row].name
    cell.pinImageView.image = places[indexPath.row].pinImage
    
    return cell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    matchedPlaces = []
    
    let location = places[indexPath.row].location
    getAllDistancesFrom(location: location!, cellRow: indexPath.row)
    
    performSegue(withIdentifier: "ShowNearbyPlaces", sender: self)
  }
  
  func getAllDistancesFrom(location: CLLocation, cellRow: Int) {
    for (i, place) in places.enumerated() {
      if i == cellRow {
        continue
      }
      
      let otherLocation = place.location
      let distance = location.distanceInKm(to: otherLocation)
      
      if distance <= 2 {
        let matchedPlace = place
        matchedPlace.distance = distance
        matchedPlaces.append(matchedPlace)
      }
    }
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    let nearbyPlacesViewController = segue.destination as! NearbyPlacesViewController
    nearbyPlacesViewController.nearbyPlaces = matchedPlaces
  }
}
