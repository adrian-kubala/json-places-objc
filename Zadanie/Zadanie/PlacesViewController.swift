//
//  PlacesViewController.swift
//  Zadanie
//
//  Created by Adrian on 09.08.2016.
//  Copyright © 2016 Adrian. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import CoreLocation

class PlacesViewController: UITableViewController {
  var places: [Place] = []
  var matchedPlaces: [Place] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let jsonURL = URL(string: "https://dl.dropboxusercontent.com/u/18389601/development/test/Location/locations.json")
    
    let parser = JSONParser(withURL: jsonURL!)
    parser.fetch { [weak self] (json, error) in
      if let error = error {
        print(error.localizedDescription)
        return
      }
      
      if let json = json {
        self?.fillPlacesWithJSON(json)
      }
    }
  }
  
  func fillPlacesWithJSON(_ json: JSON) {
    for object in json.arrayValue {
      let name = object["name"].stringValue
      let imageURL = URL(string: object["pin_url"].stringValue)
      let lat = object["coordinate"]["latitude"].doubleValue
      let lon = object["coordinate"]["longitude"].doubleValue
      
      var pinImage: UIImage?
      imageURL?.getImage { (image) in
        image?.resizeImage(newWidth: 30) { (scaledImage) in
          pinImage = scaledImage
          
          let place = Place(name: name, latitude: lat, longitude: lon, pinImage: pinImage)
          self.places.append(place)
          
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
    getAllDistancesFrom(location: location, cellRow: indexPath.row)
    
    performSegue(withIdentifier: "ShowNearbyPlaces", sender: self)
  }
  
  func getAllDistancesFrom(location: CLLocation, cellRow: Int) {
    for (i, place) in places.enumerated() {
      if i == cellRow {
        continue
      }
      
      let otherLocation = place.location
      let distance = location.distanceInKMTo(otherLocation)
      
      if distance <= 2 {
        var matchedPlace = place
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
