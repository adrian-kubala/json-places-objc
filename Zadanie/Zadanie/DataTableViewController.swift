//
//  DataTableViewController.swift
//  Zadanie
//
//  Created by Adrian on 04.08.2016.
//  Copyright © 2016 Adrian. All rights reserved.
//

import UIKit

class DataTableViewController: UITableViewController {
    
    let exoticPets: [String] = ["Wielbłąd", "Tygrys", "Pantera"]
    let pets: [String] = ["Kot", "Pies", "Szczur", "Rybki"]
    var data: [String]?
    var sectionLabel: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.data?.count)!
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("LabelCell", forIndexPath: indexPath)

        cell.textLabel?.text = self.data![indexPath.row]

        return cell
    }
 
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.sectionLabel
    }
    
}
