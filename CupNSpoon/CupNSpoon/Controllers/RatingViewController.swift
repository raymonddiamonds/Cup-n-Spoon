//
//  RatingViewController.swift
//  CupNSpoon
//
//  Created by Raymond Diamonds on 2017-07-25.
//  Copyright © 2017 Raymond Diamonds. All rights reserved.
//

import UIKit

class RatingViewController: UIViewController {
    
    var yelpID: String?
    
    var selectedHash = [String]()
    
    @IBAction func selectedHash(_ sender: UIButton) {
        
        sender.isSelected = !sender.isSelected
        
        if sender.isSelected == true {
            sender.layer.borderWidth = 0
            
            selectedHash.append(sender.currentTitle!)
            
        } else {
            sender.layer.borderWidth = 1
            selectedHash.remove(at: selectedHash.index(of: sender.currentTitle!)!)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let yelpID = yelpID else { return }
        RatingService.create(hashtags: selectedHash, yelpID: yelpID, completion: {})
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

    }




}
