//
//  URL+getImage.swift
//  JSONPlaces
//
//  Created by Adrian Kubała on 08.02.2017.
//  Copyright © 2017 Adrian. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

extension URL {
  func getImage(completion: @escaping (UIImage?) -> ()) {
    Alamofire.request(self).responseImage { (result) in
      var image: UIImage?
      if let data = result.data {
        image = UIImage(data: data)
      }
      
      completion(image)
    }
  }
}
