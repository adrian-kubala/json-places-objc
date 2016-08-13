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

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let jsonUrl = "https://dl.dropboxusercontent.com/u/18389601/development/test/Location/locations.json"
        fetchJson(jsonUrl)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return places.count ?? 0
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellRow = indexPath.row
        
        let cell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier, forIndexPath: indexPath)
        
        fillCell(cellRow, passedCell: cell)
        
        return cell
    }
    
    func fillCell(row: Int, passedCell: UITableViewCell) {
        
        if let myCell = passedCell as? MyTableViewCell {
            myCell.labelName.text = places[row].pinName
            
            let pinUrl = places[row].pinImageUrl
            
            if let cachedImage = cachedImages[row] {
                myCell.pinImage.image = cachedImage
            } else {
                getPin(pinUrl, completion: { (image) in
                    
                    self.resizeImage(image!, newWidth: 30) { (scaledImage) in
                        self.cachedImages[row] = scaledImage
                        myCell.pinImage.image = self.cachedImages[row]!
                    }
                })
            }
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

        if segue.identifier == segueIdentifier {
            if let destinationViewController = segue.destinationViewController as? PlacesTableVC {
                destinationViewController.passedPlaces = placesToPass
                destinationViewController.passedCachedImages = cachedImagesToPass
            }
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let selectedCell = indexPath.row
        
        placesToPass = []
        cachedImagesToPass = []
        
        let latitude = places[selectedCell].latitude
        let longitude = places[selectedCell].longitude
        
        getAllDistances(latitude, selectedLongitude: longitude, cellRow: selectedCell, count: places.count)
        
        performSegueWithIdentifier(segueIdentifier, sender: nil)
    }
    
    func getAllDistances(selectedLatitude: Double, selectedLongitude: Double, cellRow: Int, count: Int) {
        var i = 0
        while i < count {
            
            if i != cellRow {
                
                let otherLatitude = places[i].latitude
                let otherLongitude = places[i].longitude
                
                let distance = getDistance(selectedLatitude, aLongitude: selectedLongitude, bLatitude: otherLatitude, bLongitude: otherLongitude)
                
                if distance <= 2 {
                    placesToPass.append(places[i])
                    cachedImagesToPass.append(cachedImages[i]!)
                }
            }
            i += 1
        }
    }

    func getDistance(aLatitude: Double, aLongitude: Double, bLatitude: Double, bLongitude: Double) -> Double {
        let selectedLocation = CLLocation(latitude: aLatitude, longitude: aLongitude)
        let otherLocation = CLLocation(latitude: bLatitude, longitude: bLongitude)
        
        return selectedLocation.distanceFromLocation(otherLocation) / 1000
    }
    
    func resizeImage(image: UIImage, newWidth: CGFloat, completion: (scaledImage: UIImage) -> ()) {
        
        let qualityOfServiceClass = QOS_CLASS_BACKGROUND
        let backgroundQueue = dispatch_get_global_queue(qualityOfServiceClass, 0)
        dispatch_async(backgroundQueue, {
            // This is run on the background queue
            
            let scale = newWidth / image.size.width
            let newHeight = image.size.height * scale
            UIGraphicsBeginImageContext(CGSizeMake(newWidth, newHeight))
            image.drawInRect(CGRectMake(0, 0, newWidth, newHeight))
            let newImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                // This is run on the main queue, after the previous code in outer block
                completion(scaledImage: newImage)
            })
        })
    }
    
    func fetchJson(url: String) {
        Alamofire.request(.GET, url).validate().responseJSON { response in
            switch response.result {
            case .Success:
                if let value = response.result.value {
                    self.fillPlacesWithJson(JSON(value))
                    self.tableView.reloadData()
                }
            case .Failure(let error):
                print(error)
            }
        }
    }
    
    func fillPlacesWithJson(json:JSON?) {
        
        for object in (json?.array)! {
            let name = object["name"].stringValue
            let image = object["pin_url"].stringValue
            let lat = object["coordinate"]["latitude"].doubleValue
            let lon = object["coordinate"]["longitude"].doubleValue
            
            let place = Place(pinImageUrl: image, pinName: name, latitude: lat, longitude: lon)
            places.append(place)
        }
    }
    
    func getPin(url: String, completion: (UIImage?) -> ()) {
        Alamofire.request(.GET, url).response() {
            (_, _, data, _) in
            let image = UIImage(data: data! )
            completion(image)
        }
    }
}
