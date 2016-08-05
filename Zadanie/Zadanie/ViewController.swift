//
//  ViewController.swift
//  Zadanie
//
//  Created by Adrian on 03.08.2016.
//  Copyright © 2016 Adrian. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var labelaction: UILabel!
    var count = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    @IBAction func action(sender: UIButton) {
        
        labelaction.text = "Zmieniono \(count) raz"
        count += 1

        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if let controller = segue.destinationViewController as? PetsTableViewController {
            controller.data = ["x", "y"]
        }
        
        
    }
    
}

 