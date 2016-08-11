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

class JsonTableViewController: UITableViewController {
    
    var json: JSON?
    let reuseIdentifier = "cell"
    let segueIdentifier = "mapSegue"
    var latitude: Double?
    var longitude: Double?
    var pinImageForMap: UIImage?
    var pinNameForMap: String?


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
        return json?.array?.count ?? 0
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier, forIndexPath: indexPath)

        let cellRow = indexPath.row
        
        if let myCell = cell as? MyTableViewCell {
            myCell.labelName.text = json![cellRow]["name"].stringValue
            
            let pinUrl = json![cellRow]["pin_url"].stringValue
            getPin(pinUrl, completion: { (image) in
                
                self.resizeImage(image!, newWidth: 30) { (scaledImage) in
                    myCell.pinImage.image = scaledImage
                }
            })
        }
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

        if segue.identifier == segueIdentifier {
            if let destinationViewController = segue.destinationViewController as? MapViewController {
                destinationViewController.mapLatitude = latitude
                destinationViewController.mapLongitude = longitude
                destinationViewController.mapPinImage = pinImageForMap
                destinationViewController.mapPinName = pinNameForMap
            }
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let selectedCell = indexPath.row
        
        latitude = json![selectedCell]["coordinate"]["latitude"].doubleValue
        longitude = json![selectedCell]["coordinate"]["longitude"].doubleValue
        pinNameForMap = json![selectedCell]["name"].stringValue

        let tempCell = tableView.cellForRowAtIndexPath(indexPath)
        pinImageForMap = (tempCell as! MyTableViewCell).pinImage.image
        
        performSegueWithIdentifier(segueIdentifier, sender: nil)
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
                    self.json = JSON(value)
                    self.tableView.reloadData()
                }
            case .Failure(let error):
                print(error)
            }
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
