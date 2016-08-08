//
//  ViewController.swift
//  Zadanie
//
//  Created by Adrian on 08.08.2016.
//  Copyright © 2016 Adrian. All rights reserved.
//

import UIKit


class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    let reuseIdentifier = "cell" // also enter this string as the cell identifier in the storyboard
    var items: [UIImage]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        items = [UIImage(named: "8")!, UIImage(named: "11")!, UIImage(named: "fun")!, UIImage(named: "cloud_fun")!, UIImage(named: "cream_funny")!, UIImage(named: "happy-2")!, UIImage(named: "happy")!, UIImage(named: "emoticons")!]
    }
    
    // MARK: - UICollectionViewDataSource protocol
    
    // tell the collection view how many cells to make
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items!.count
    }
    
    // make a cell for each cell index path
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        // get a reference to our storyboard cell
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! MyCollectionViewCell
        
        // Use the outlet in our custom class to get a reference to the UILabel in the cell
        cell.myImage.image = self.items![indexPath.item]
         // make cell more visible in our example project
        
        return cell
    }
    
    // MARK: - UICollectionViewDelegate protocol
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        // handle tap events
        print("You selected cell #\(indexPath.item)!")
    }
}