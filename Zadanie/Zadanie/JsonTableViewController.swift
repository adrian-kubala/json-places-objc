//
//  JsonTableViewController.swift
//  Zadanie
//
//  Created by Adrian on 09.08.2016.
//  Copyright © 2016 Adrian. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import AlamofireImage
import CoreLocation

class JsonTableViewController: UITableViewController {
  
  let reuseIdentifier = "cell"
  let segueIdentifier = "placesSegue"
  
  var cachedImages = [Int : UIImage?]()
  var cachedImagesToPass = [UIImage?]()
  
  var places = [Place]()
  var placesToPass = [Place]()
  
  var distancesToPass = [Double]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let jsonUrl = "https://dl.dropboxusercontent.com/u/18389601/development/test/Location/locations.json"
    fetchJson(jsonUrl)
  }
  
  func fetchJson(_ url: String) {
    Alamofire.request(url).validate().responseJSON { response in
      switch response.result {
      case .success(let value):
        self.fillPlacesWithJson(JSON(value))
        self.tableView.reloadData()
      case .failure(let error):
        print(error)
      }
    }
  }
  
  func fillPlacesWithJson(_ json: JSON?) {
    
    for object in (json?.array)! {
      let name = object["name"].stringValue
      let imageUrl = object["pin_url"].stringValue
      let lat = object["coordinate"]["latitude"].doubleValue
      let lon = object["coordinate"]["longitude"].doubleValue
      
      let place = Place(name: name, pinUrl: imageUrl, latitude: lat, longitude: lon)
      places.append(place)
    }
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return places.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cellRow = indexPath.row
    
    let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
    
    fillCell(cellRow, passedCell: cell)
    
    return cell
  }
  
  func fillCell(_ row: Int, passedCell: UITableViewCell) {
    guard let myCell = passedCell as? MyTableViewCell else {
      return
    }
    
    myCell.labelName.text = places[row].name
    
    let pinUrl = places[row].pinUrl
    
    guard let cachedImage = cachedImages[row] else {
      getPin(pinUrl, completion: { (image) in
        
        self.resizeImage(image!, newWidth: 30) { (scaledImage) in
          self.cachedImages[row] = scaledImage
          myCell.pinImage.image = self.cachedImages[row]!
        }
      })
      return
    }
    
    myCell.pinImage.image = cachedImage
  }
  
  func getPin(_ url: String, completion: @escaping (UIImage?) -> ()) {
    Alamofire.request(url).responseImage { (image) in
      let image = UIImage(data: image.data!)
      completion(image)
    }
  }
  
  func resizeImage(_ image: UIImage, newWidth: CGFloat, completion: @escaping (_ scaledImage: UIImage) -> ()) {
    
    let qualityOfServiceClass = DispatchQoS.QoSClass.background
    let backgroundQueue = DispatchQueue.global(qos: qualityOfServiceClass)
    backgroundQueue.async(execute: {
      // This is run on the background queue
      
      let scale = newWidth / image.size.width
      let newHeight = image.size.height * scale
      UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
      image.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
      let newImage = UIGraphicsGetImageFromCurrentImageContext()
      UIGraphicsEndImageContext()
      
      DispatchQueue.main.async(execute: { () -> Void in
        // This is run on the main queue, after the previous code in outer block
        completion(newImage!)
      })
    })
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let selectedCell = indexPath.row
    
    placesToPass = []
    cachedImagesToPass = []
    distancesToPass = []
    
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
      let otherCoordiante = CLLocationCoordinate2DMake(otherLatitude, otherLongitude)
      
      let distance = getDistanceInKm(from: placeCoordinate, to: otherCoordiante)
      
      guard distance <= 2 else {
        continue
      }
      
      placesToPass.append(places[i])
      cachedImagesToPass.append(cachedImages[i]!)
      distancesToPass.append(distance)
    }
  }
  
  func getDistanceInKm(from place: CLLocationCoordinate2D, to otherPlace: CLLocationCoordinate2D) -> Double {
    let firstLocation = CLLocation(latitude: place.latitude, longitude: place.longitude)
    let secondLocation = CLLocation(latitude: otherPlace.latitude, longitude: otherPlace.longitude)
    
    let distance = secondLocation.distance(from: firstLocation) / 1000
    return Double(distance)
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    guard segue.identifier == segueIdentifier else {
      return
    }
    
    guard let destinationViewController = segue.destination as? PlacesTableVC else {
      return
    }
    
    destinationViewController.passedPlaces = placesToPass
    destinationViewController.passedCachedImages = cachedImagesToPass
    destinationViewController.distances = distancesToPass
  }
}
