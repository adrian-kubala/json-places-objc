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


    override func viewDidLoad() {
        super.viewDidLoad()
        
        let jsonUrl = "https://dl.dropboxusercontent.com/u/18389601/development/test/Location/locations.json"
        fetchJson(jsonUrl)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        return json?.array?.count ?? 0
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier, forIndexPath: indexPath)

        let cellRow = indexPath.row
        
        if let myCell = cell as? MyTableViewCell {
            myCell.labelName.text = json![cellRow]["name"].stringValue
            
            let longitude = json![cellRow]["coordinate"]["longitude"].doubleValue
            let latitude = json![cellRow]["coordinate"]["latitude"].doubleValue
            
            let pinUrl = json![cellRow]["pin_url"].stringValue
            getPin(pinUrl, completion: { (image) in
                myCell.pinImage.image = image
            })
            
        }
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "mapSegue" {
            var secondViewController = segue.destinationViewController as MapViewController
            var indexPath = tableView.indexPathForSelectedRow
            
        }
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
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
