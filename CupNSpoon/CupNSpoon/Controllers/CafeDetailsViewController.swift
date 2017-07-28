//
//  CafeDetailsViewController.swift
//  CupNSpoon
//
//  Created by Raymond Diamonds on 2017-07-13.
//  Copyright © 2017 Raymond Diamonds. All rights reserved.
//

import UIKit

private let reuseIdentifier = "hashtag"

class CafeDetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var hashtagLabel: UILabel!
    @IBOutlet weak var cafeNameLabel: CafeLabel!
    @IBOutlet weak var backgroundPic: UIImageView!
    @IBOutlet weak var addressDetails: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var avgYelpStar: UIImageView!
    @IBOutlet weak var reviewCount: UILabel!
    @IBAction func yelpURL(_ sender: Any) {
        
    }
    
    var reviewList = [Review]()
    
    var cafe: Cafe?
    var phoneNum: String = ""
    var imageURL: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        if let currentCafe = cafe {
            print(currentCafe.address)
            
            addressDetails.text = currentCafe.address
            cafeNameLabel.text = currentCafe.name
            phoneNum = currentCafe.phoneNum
            imageURL = currentCafe.imageURL
            
            reviewCount.text = "\(Int(currentCafe.reviewCount)) reviews"
            
            avgYelpStar.image = UIImage(named:   currentCafe.rating.getImageName())
            
            
            let reviewURL = "https://api.yelp.com/v3/businesses/\(currentCafe.id)/reviews"
            
            
            
            //code to get the ratings for all of our cafes in cafeList
            YelpClientService.getReviews(url: reviewURL, completionHandler:
                { (receivedReviews) in
                    self.reviewList = receivedReviews!
                    
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
            })
            
            //Retrieve hashtags/count from Firebase
            RatingService.retrieveForCafe(yelpID: (cafe?.id)! , completion: { (tags) in
                self.cafe?.hashtagCounts = tags
                
                /*for individualKey in Array(tags.keys)
                {
                    if self.featuresTextView.text != ""
                    {
                        self.featuresTextView.text = "\(self.featuresTextView.text!)   #\(individualKey): \(tags[individualKey]!)"
                    }
                    else
                    {
                        self.featuresTextView.text = "#\(individualKey): \(tags[individualKey]!)"
                    }
                }*/

            })
        }
        else {
            print("is nil")
        }
        
        // Making back button colour on nav controller white
        self.navigationController?.navigationBar.tintColor = UIColor.white
        
        // Adding background cafe pic using kingfisher
        let backgroundPicURL = URL(string: self.imageURL)
        backgroundPic.kf.setImage(with: backgroundPicURL)
        
        // Create a subview which will add an overlay effect on image view
        if backgroundPic.viewWithTag(98) == nil {
            let overlay = UIView(frame: CGRect(x: 0,y: 0,width: backgroundPic.frame.size.width, height: backgroundPic.frame.size.height))
            overlay.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.55)
            overlay.tag = 98
            
            //Add the subview to the UIImageView
            backgroundPic.addSubview(overlay)
        }
    }
    
    
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
     return (cafe?.hashtagCounts?.count)!
     }
     
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
     let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! HashtagCell
     
     return cell
     }
    
    
    
    //creating # of tableView sections
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    //creating # of tableView cells
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviewList.count
    }
    
    //creating individual tableView cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "reviewCell", for: indexPath) as! ReviewCell
        
        let review = reviewList[indexPath.row]
        
        print(review.userName)
        
        cell.userName.text = review.userName
        cell.reviewText.text = review.text
        cell.date.text = review.timeCreated.components(separatedBy: " ")[0]
        
        cell.yelpStars.image = UIImage(named: review.rating.getImageName())
        
        //cell.date.text = review.timeCreated
        
        return cell
    }
    
    func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addRating" {
            if let destinationVC = segue.destination as? RatingViewController {
                destinationVC.yelpID = (cafe?.id)!
            }
        }
        
    }
    
    @IBAction func unwindToCafeDetailsViewController(_ segue: UIStoryboardSegue) {
    }
    
}
