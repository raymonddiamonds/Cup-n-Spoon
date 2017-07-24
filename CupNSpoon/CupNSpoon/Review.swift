//
//  Review.swift
//  CupNSpoon
//
//  Created by Raymond Diamonds on 2017-07-19.
//  Copyright © 2017 Raymond Diamonds. All rights reserved.
//

import Foundation
import UIKit

class Review {
    var rating: Rating
    var userName: String
    var text: String
    var timeCreated: String
    var url: String
    
    init(rating: Rating, userName: String, text: String, timeCreated: String, url: String){
        self.rating = rating
        self.userName = userName
        self.text = text
        self.timeCreated = timeCreated
        self.url = url
        
        //let image = UIImage(named: self.rating.rawValue)
        
    }
    
}
