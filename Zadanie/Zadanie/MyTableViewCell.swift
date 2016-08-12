//
//  MyTableViewCell.swift
//  Zadanie
//
//  Created by Adrian on 09.08.2016.
//  Copyright © 2016 Adrian. All rights reserved.
//

import UIKit

class MyTableViewCell: UITableViewCell {

    @IBOutlet weak var pinImage: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    
    @IBOutlet weak var placeImage: UIImageView!
    @IBOutlet weak var placeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
