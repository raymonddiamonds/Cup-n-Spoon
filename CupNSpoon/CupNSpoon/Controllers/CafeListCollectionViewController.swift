//
//  CafeListCollectionViewController.swift
//  Cup'N'Spoon
//
//  Created by Raymond Diamonds on 2017-07-10.
//  Copyright © 2017 Raymond Diamonds. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher

private let reuseIdentifier = "cafeCell"

class CafeListCollectionViewController: UICollectionViewController,UICollectionViewDelegateFlowLayout {

    var cafeList = [Cafe]()

    var currentCafe: Cafe?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let requestParams: Parameters = ["term": "cafe", "location": "3433 rue Durocher, Montreal", "sort_by": "best_match", "limit": 50]
        
        let baseURL = "https://api.yelp.com/v3/businesses/search"
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer ZVSFGHzgWxncnt5-vre17_advOlPsETIy8UOEsk58V_cMSSgPRCVTL4p7p1zpJBYwuJR-3RMjZFTg1BnXdleKVLecGuYtEqYOrzrsxv2s2mhuMUcpd-0JfRI7JlmWXYx"
        ]

        
        YelpClientService.getBusinesses(url: baseURL, parameters: requestParams, headers: headers) { (receivedCafes) in
            self.cafeList = receivedCafes
            self.collectionView?.reloadData()
        }
        
        collectionView?.backgroundColor = UIColor(red:0.96, green:0.95, blue:0.94, alpha:1.0)

    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cafeList.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CafeCell
        
        //Configure the cell

        //populating cell w/ cafeName,cafeAddress,cafeImage from cafe obj Array
        let cafe = cafeList[indexPath.row]
        
        cell.cafeName.text = cafe.name
        
        cell.cafeAddress.text = cafe.address
        
        print(cafe.distance)
        
        let imageURL = URL(string: cafe.imageURL)
        cell.cafeImage.kf.setImage(with: imageURL)
        
        // Create a subview which will add an overlay effect on image view
        if cell.cafeImage.viewWithTag(98) == nil {
            let overlay = UIView(frame: CGRect(x: 0,y: 0,width: cell.cafeImage.frame.size.width, height: cell.cafeImage.frame.size.height))
            overlay.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.55)
            //0.37
            overlay.tag = 98
            
            //Add the subview to the UIImageView
            cell.cafeImage.addSubview(overlay)
        }
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //perform segue and the sender should be the object of the array in the index path
        
        currentCafe = cafeList[indexPath.row]
        performSegue(withIdentifier: "itemSelectedSegue", sender: self)
    }
    //prepare destination view
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "itemSelectedSegue" {
            if let destinationVC = segue.destination as? CafeDetailsViewController {
                if let temporaryCurrentCafe = currentCafe {
                    destinationVC.cafe = temporaryCurrentCafe
                }
            }
        }
    }
    
    
    //dynamically resizing Collecting View cell
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let height = self.view.frame.size.height;
        let width = self.view.frame.size.height;
        
        return CGSize(width: width*0.25, height: height*0.25)
        
        //return CGSize(width: width*0.26, height: height*0.26)
        
//        return CGSize(width: CGFloat((collectionView.frame.size.width / 2) - 20), height: CGFloat(100))
    } 
    

    


}
