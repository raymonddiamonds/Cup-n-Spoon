//
//  YelpClientService.swift
//  CupNSpoon
//
//  Created by Raymond Diamonds on 2017-07-13.
//  Copyright © 2017 Raymond Diamonds. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class YelpClientService {
    var cafes = [String]()
    
    static func getBusinesses(url: String, parameters: Parameters, headers: HTTPHeaders, completionHandler: @escaping ([Cafe])-> Void) {
        
        Alamofire.request(url, parameters: parameters, encoding: URLEncoding.default, headers: headers).responseJSON { (response) in
            let json = JSON(with: response.data)
            let businesses = json["businesses"].array
            print(businesses)
            
            var cafes = [Cafe]()
            for business in businesses! {
                let name = business["name"].stringValue
                let imageURL = business["image_url"].stringValue
                let cafe = Cafe(name: name, imageURL: imageURL)
                cafes.append(cafe)
            }
            
            
            completionHandler(cafes)
            print(json)
        }
    }
}
