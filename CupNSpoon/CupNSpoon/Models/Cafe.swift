//
//  Cafe.swift
//  Cup'N'Spoon
//
//  Created by Raymond Diamonds on 2017-07-11.
//  Copyright © 2017 Raymond Diamonds. All rights reserved.
//

import Foundation
import Kingfisher

struct Cafe {
    //Mark: Properties
    var name: String
    var id: String
    var imageURL: String
    var address: String
    var distance: Double
    var phoneNum: String
    var rating: Rating
    var reviewCount: Double
    var hashtagCounts: [String:Int]?
    var totalRatingsCount: Int?
    var isClosed: Bool
    
    init(name: String, id: String, imageURL: String, address: String, distance: Double, phoneNum: String, rating: Rating, reviewCount: Double, isClosed: Bool) {
        self.name = name
        self.id = id
        self.imageURL = imageURL
        self.address = address
        self.distance = distance
        self.phoneNum = phoneNum
        self.rating = rating
        self.reviewCount = reviewCount
        self.isClosed = isClosed

    }

    
}
