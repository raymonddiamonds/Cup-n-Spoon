//
//  CafeDetailsViewController.swift
//  CupNSpoon
//
//  Created by Raymond Diamonds on 2017-07-13.
//  Copyright © 2017 Raymond Diamonds. All rights reserved.
//

import UIKit


class CafeDetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var cafeNameLabel: CafeLabel!
    @IBOutlet weak var backgroundPic: UIImageView!
    @IBOutlet weak var addressDetails: UILabel!
    @IBOutlet weak var tableView: UITableView!


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
            
            
            let reviewURL = "https://api.yelp.com/v3/businesses/\(currentCafe.id)/reviews"
            
            //code to get the ratings for all of our cafes in cafeList
            YelpClientService.getReviews(url: reviewURL, completionHandler: 
                { (receivedReviews) in
                    self.reviewList = receivedReviews!
                    
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                        
                }


            })

        }
        else {
            print("is nil")
        }
        
//        func phoneButton(_ sender: Any) {
//            
//            if let phoneURL = NSURL(string: "tel://\(phoneNum)") {
//                UIApplication.shared.openURL(phoneURL as URL)
//            }
//        }
        
        //adding background cafe pic
        let backgroundPicURL = URL(string: self.imageURL)
        backgroundPic.kf.setImage(with: backgroundPicURL)
        
        // Create a subview which will add an overlay effect on image view
        if backgroundPic.viewWithTag(98) == nil {
            let overlay = UIView(frame: CGRect(x: 0,y: 0,width: backgroundPic.frame.size.width, height: backgroundPic.frame.size.height))
            overlay.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.55)
            //0.37
            overlay.tag = 98
            
            //Add the subview to the UIImageView
            backgroundPic.addSubview(overlay)
        }
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    //creating # of tableView cells
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviewList.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "reviewCell", for: indexPath) as! ReviewCell
        
        let review = reviewList[indexPath.row]
        
        print(review.userName)
        
        cell.userName.text = review.userName
        cell.reviewText.text = review.text

        cell.yelpStars.image = UIImage(named: review.rating.rawValue)
        
        
        
        
        //cell.date.text = review.timeCreated



        return cell
        
    }

}

//extension to convert Date type to String
extension Date
{
    func toString( dateFormat format  : String ) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
    
}
