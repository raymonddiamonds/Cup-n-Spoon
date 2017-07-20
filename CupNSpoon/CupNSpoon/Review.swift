//
//  Review.swift
//  CupNSpoon
//
//  Created by Raymond Diamonds on 2017-07-19.
//  Copyright © 2017 Raymond Diamonds. All rights reserved.
//

import Foundation

class Review {
    var rating: Double
    var userName: String
    var text: String
    var timeCreated: Date
    var url: String
    
    init(rating: Double, userName: String, text: String, timeCreated: Date, url: String){
        self.rating = rating
        self.userName = userName
        self.text = text
        self.timeCreated = timeCreated
        self.url = url
        
    }
    
}
