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
  
  let reuseIdentifier = "cell"
  let segueIdentifier = "placesSegue"
  
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
        self?.fillPlacesWithJson(json)
      }
    }
  }
  
  func fillPlacesWithJson(_ json: JSON) {
    for object in json.arrayValue {
      let name = object["name"].stringValue
      let imageUrl = URL(string: object["pin_url"].stringValue)
      let lat = object["coordinate"]["latitude"].doubleValue
      let lon = object["coordinate"]["longitude"].doubleValue
      
      var pinImage: UIImage?
      imageUrl?.getImage { (image) in
        image?.resizeImage(newWidth: 30) { (scaledImage) in
          pinImage = scaledImage
          
          let place = Place(name: name, pinImage: pinImage, latitude: lat, longitude: lon, distance: nil)
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
    let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! PlaceView
    
    cell.label.text = places[indexPath.row].name
    cell.pinImageView.image = places[indexPath.row].pinImage
    
    return cell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let selectedCell = indexPath.row
    
    matchedPlaces = []
    
    let latitude = places[selectedCell].latitude
    let longitude = places[selectedCell].longitude
    let coordinates = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    
    getAllDistances(coordinates, cellRow: selectedCell)
    
    performSegue(withIdentifier: segueIdentifier, sender: self)
  }
  
  func getAllDistances(_ placeCoordinate: CLLocationCoordinate2D, cellRow: Int) {
    for (i, _) in places.enumerated() {
      guard i != cellRow else {
        continue
      }
      
      let otherLatitude = places[i].latitude
      let otherLongitude = places[i].longitude
      let otherCoordinate = CLLocationCoordinate2DMake(otherLatitude, otherLongitude)
      
      let distance = placeCoordinate.distanceInKMTo(otherCoordinate)
      
      guard distance <= 2 else {
        continue
      }
      
      var place = places[i]
      place.distance = distance
      matchedPlaces.append(place)
    }
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    guard segue.identifier == segueIdentifier else {
      return
    }
    
    guard let destinationViewController = segue.destination as? NearbyPlacesViewController else {
      return
    }
    
    destinationViewController.nearbyPlaces = matchedPlaces
  }
}
