//
//  Cafe.swift
//  Cup'N'Spoon
//
//  Created by Raymond Diamonds on 2017-07-11.
//  Copyright © 2017 Raymond Diamonds. All rights reserved.
//

import Foundation
import Kingfisher

class Cafe {
    //Mark: Properties
    var name: String
    var id: String
    var imageURL: String
    var address: String
    var distance: Double
    var phoneNum: String
    var rating: Double

    


    
    init(name: String, id: String, imageURL: String, address: String, distance: Double, phoneNum: String, rating: Double) {
        self.name = name
        self.id = id
        self.imageURL = imageURL
        self.address = address
        self.distance = distance
        self.phoneNum = phoneNum
        self.rating = rating

    }

    
}
