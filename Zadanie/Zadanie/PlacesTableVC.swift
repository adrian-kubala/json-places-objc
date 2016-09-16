//
//  PlacesTableVC.swift
//  Zadanie
//
//  Created by Adrian on 11.08.2016.
//  Copyright © 2016 Adrian. All rights reserved.
//

import UIKit

class PlacesTableVC: UITableViewController {
    var passedPlaces = [Place]()
    var passedCachedImages = [UIImage?]()
    var distances = [Double]()
    
    var reuseIdentifier = "placesTableCell"

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return passedPlaces.count ?? 0
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier, forIndexPath: indexPath)
        
        let cellIndex = indexPath.row
        
        if let myCell = cell as? MyTableViewCell {
            
            myCell.placeImage.image = passedCachedImages[cellIndex]!
            myCell.placeLabel.text = passedPlaces[cellIndex].pinName
        }
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let latitude = passedPlaces[indexPath.row].latitude
        let longitude = passedPlaces[indexPath.row].longitude
        let distance = distances[indexPath.row]
        
        let alert = UIAlertController(title: "Współrzędne", message: "Szerokość: \(latitude)\nDługość: \(longitude)\nOdległość: \(String(format:"%.2f", distance)) km", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
}
