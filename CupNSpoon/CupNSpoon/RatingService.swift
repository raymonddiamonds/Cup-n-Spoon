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
                
                let tag = tag.trimmingCharacters(in: CharacterSet(charactersIn : "#"))
                
                let countRefCafes = Database.database().reference().child("cafes").child(yelpID).child(tag)
                
                
                countRefCafes.runTransactionBlock({ (mutableData) -> TransactionResult in
                    
                    let currentCount = mutableData.value as? Int ?? 0
                    
                    mutableData.value = currentCount + 1
                    
                    if currentCount + 1 > 3 {
                        
                        let hashtagsRef = Database.database().reference().child("hashtags").child(tag).child(yelpID)
                        hashtagsRef.setValue(currentCount + 1)

                    }
                    
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
            if error != nil {
                completion([:])
                return
            }
            
            let ref = Database.database().reference().child("cafes").child(yelpID)
            
            ref.observeSingleEvent(of: .value, with: { (snapshot) in
                guard let snapshot = snapshot.value as? [String: Int] else {
                    return completion([:])
                }
                
                completion(snapshot)
                
            })
            
            
        }
    }
    
    static func filterCafesByHastags(yelpIDs: [String], hashtags: [String], completion: @escaping ([String]?) -> Void) {
        
        let yelpIDs = Set<String>(yelpIDs)
        let hashtags = Set<String>(hashtags)
        var result = [String]()
        
        /*
        if Auth.auth().current != nil {
            
        } else {
            AppDelegate.sign
        }
        */
        Auth.auth().signInAnonymously() { (user, error) in
            if error != nil {
                completion([])
                return
            }
            
            let group = DispatchGroup()
            for hashtag in hashtags {
                let ref = Database.database().reference().child("hashtags").child(hashtag)
                group.enter()
                ref.observeSingleEvent(of: .value, with: { snapshot in
                    guard let snapshotArray = snapshot.children.allObjects as? [DataSnapshot] else {
                        return completion([])
                    }
                    for snap in snapshotArray {
                        result.append(snap.key)
                    }
                    group.leave()
                })
       
            }
            group.notify(qos: .userInitiated, queue: .global(), execute: {
                let finalArray = Array(yelpIDs.intersection(result))
                completion(finalArray)
            })
            
            
            
            
            // sign in
            
            // get reference to cafes
            // query ordered by child -- hashtag
            // query starting at value -- 1
            // send off request (observe single event?)
            // check for errors
            // snapshot -> json
            // parse through json -> populate cafe array
            // reverse order of cafes
            // call completion
            
            
            //filter by yelpID from FB and yelpID array
            //filter by hashtag
            //return yelpID that contains those two
            
            
        }
    }
    
}
