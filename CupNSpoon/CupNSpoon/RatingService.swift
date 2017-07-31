//
//  RatingService.swift
//  CupNSpoon
//
//  Created by Raymond Diamonds on 2017-07-27.
//  Copyright © 2017 Raymond Diamonds. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseAuth
import SwiftyJSON

struct RatingService {
    
    static var hashtagCallCount = 0
    
    static func create(hashtags: [String], yelpID: String, completion: @escaping () -> Void) {
        
        Auth.auth().signInAnonymously() { (user, error) in
            if error != nil { return }
            
            for tag in hashtags {
                
                hashtagCallCount += 1
                
                let countRef = Database.database().reference().child("cafes").child(yelpID).child(tag.trimmingCharacters(in: CharacterSet(charactersIn : "#")))
                countRef.runTransactionBlock({ (mutableData) -> TransactionResult in
                    
                    let currenCount = mutableData.value as? Int ?? 0
                    
                    mutableData.value = currenCount + 1
                    
                    return TransactionResult.success(withValue: mutableData)
                    
                }, andCompletionBlock: { (error, _, _) in
                    
                    hashtagCallCount -= 1
                    
                    if hashtagCallCount == 0 {
                        completion()
                    }
                })
            }
        }
    }
    
    static func retrieveForCafe(yelpID: String, completion: @escaping ([String:Int]) -> Void) {
        
        Auth.auth().signInAnonymously() { (user, error) in
            if error != nil { return }
            
            let ref = Database.database().reference().child("cafes").child(yelpID)
            
            ref.observeSingleEvent(of: .value, with: { (snapshot) in
                
                guard let snapshot = snapshot.value as? [String: Int] else {
                    return completion([:])
                }
                

                
                completion(snapshot)
            
            })
            
            /*
             ref.observeSingleEvent(of: .value, with: { (snapshot) in
             guard let snapshot = snapshot.children.allObjects as? [DataSnapshot] else {
             return completion([])
             }
             
             let posts = snapshot.reversed().flatMap(Post.init)
             completion(posts)
             })*/
        }
    }
    
    static func filterCafesByHastags(yelpIDs: [String], hashtags: String, completion: @escaping ([Cafe]) -> Void) {
        
    }
    
    
    
}
