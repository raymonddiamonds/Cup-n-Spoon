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
            let json = JSON(with: response.data as Any)
            let businesses = json["businesses"].array
            print(businesses as Any)
            
            var cafes = [Cafe]()
            for business in businesses! {
                let name = business["name"].stringValue
                let imageURL = business["image_url"].stringValue
                let address = business["location"]["address1"].stringValue
                let distance = business["distance"].doubleValue
                let phoneNum = business["phone"].stringValue
                let id = business["id"].stringValue
                let ratingDouble = business["rating"].doubleValue
                
                let rating = String.init(format: "%.1f", ratingDouble)
                


                let cafe = Cafe(name: name, id: id, imageURL: imageURL, address: address, distance: distance, phoneNum: phoneNum, rating: Rating(rawValue: rating)!)
                cafes.append(cafe)
            }
            
            
            completionHandler(cafes)
            print(json)
        }
    }
    
    static func getReviews(url: String, completionHandler: @escaping ([Review]?)-> Void)
    {
        let httpHeaders: HTTPHeaders = ["Authorization": "Bearer \(UserDefaults.standard.string(forKey: "token") ?? "")"]
        
        //removing diacritics from the URL
        if let requestUrl = URL(string: url.folding(options: .diacriticInsensitive, locale: .current))
        {
            Alamofire.request(requestUrl, encoding: URLEncoding.default, headers: httpHeaders).responseJSON { (returnedResponse) in
                let returnedJson = JSON(with: returnedResponse.data as Any)
                let reviewArray = returnedJson["reviews"].array
                print(reviewArray as Any)
                
                var reviews = [Review]()
                
                for review in reviewArray! {
                    
                    let userName = review["user"]["name"].stringValue
                    
                    let ratingDouble = review["rating"].doubleValue
                    let rating = String.init(format: "%.1f", ratingDouble)
           
                    let text = review["text"].stringValue
                    
                    let formatter = DateFormatter()
                    formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                    
                    let timeCreated =  formatter.date(from: review["time_created"].stringValue)
                    
                    
                    let url = review["url"].stringValue
                    
                    let review = Review(rating: Rating(rawValue: rating)!, userName: userName, text: text, timeCreated: timeCreated!, url: url)
                    reviews.append(review)
                    
                }
                
                completionHandler(reviews)

            }
        }
        else
        {
            print("invalid url")
            completionHandler(nil)
        }
    }
}


