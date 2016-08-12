//
//  PlacesTableVC.swift
//  Zadanie
//
//  Created by Adrian on 11.08.2016.
//  Copyright © 2016 Adrian. All rights reserved.
//

import UIKit
import SwiftyJSON

class PlacesTableVC: UITableViewController {
    
    var passedPlaces = [Place]()
    var passedCachedImages = [UIImage?]()
    
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
}