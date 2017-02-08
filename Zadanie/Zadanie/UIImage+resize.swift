//
//  UIImage+resize.swift
//  Zadanie
//
//  Created by Adrian Kubała on 08.02.2017.
//  Copyright © 2017 Adrian. All rights reserved.
//

import UIKit

extension UIImage {
  func resizeImage(newWidth: CGFloat, completion: @escaping (_ scaledImage: UIImage) -> ()) {
    DispatchQueue.global(qos: .background).async {
      
      let scale = newWidth / self.size.width
      let newHeight = self.size.height * scale
      
      UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
      self.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
      let newImage = UIGraphicsGetImageFromCurrentImageContext()!
      UIGraphicsEndImageContext()
      
      DispatchQueue.main.async {
        completion(newImage)
      }
    }
  }
}
