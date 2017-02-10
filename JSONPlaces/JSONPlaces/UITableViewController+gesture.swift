//
//  UITableViewController+gesture.swift
//  JSONPlaces
//
//  Created by Adrian Kubała on 09.02.2017.
//  Copyright © 2017 Adrian. All rights reserved.
//

import UIKit

extension UITableViewController {
  func addLongPressGestureRecognizer(selector: Selector) {
    let recognizer = UILongPressGestureRecognizer.init(target: self, action: selector)
    tableView.addGestureRecognizer(recognizer)
  }
}
