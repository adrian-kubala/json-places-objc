//
//  JSONParser.swift
//  Zadanie
//
//  Created by Adrian Kubała on 08.02.2017.
//  Copyright © 2017 Adrian. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class JSONParser {
  let source: URL
  
  init(withURL url: URL) {
    source = url
  }
  
  func fetch(completion: @escaping (_ json: JSON?, _ error: Error?) -> ()) {
    Alamofire.request(source).validate().responseJSON { response in
      switch response.result {
      case .success(let value):
        completion(JSON(value), nil)
      case .failure(let error):
        completion(nil, error)
      }
    }
  }
}
