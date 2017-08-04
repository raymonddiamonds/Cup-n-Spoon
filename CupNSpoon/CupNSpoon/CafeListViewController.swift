//
//  CafeListViewController.swift
//  CupNSpoon
//
//  Created by Raymond Diamonds on 2017-08-01.
//  Copyright © 2017 Raymond Diamonds. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher

class CafeListViewController: UIViewController{
    
    
    @IBOutlet weak var studyCollectionView: UICollectionView!
    @IBOutlet weak var brunchCollectionView: UICollectionView!
    
    @IBOutlet weak var businessCollectionView: UICollectionView!
    @IBOutlet weak var photographyCollectionView: UICollectionView!
    @IBOutlet weak var exploreCollectionView: UICollectionView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    var currentCafe: Cafe?
    var allCafeList = [Cafe]()
    var yelpIDs = [String]()
    
    var studyCafeList = [Cafe]()
    var brunchCafeList = [Cafe]()
    var businessCafeList = [Cafe]()
    var photographyCafeList = [Cafe]()
    var exploreCafeList = [Cafe]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK: Delegate
        studyCollectionView.delegate = self
        brunchCollectionView.delegate = self
        businessCollectionView.delegate = self
        photographyCollectionView.delegate = self
        exploreCollectionView.delegate = self
        
        // datasource
        studyCollectionView.dataSource = self
        brunchCollectionView.dataSource = self
        businessCollectionView.dataSource = self
        photographyCollectionView.dataSource = self
        exploreCollectionView.dataSource = self
        
        // Yelp Request: Parameter, httpURL, Header, Request
        let requestParams: Parameters = ["term": "cafe", "location": "3433 rue Durocher, Montreal", "sort_by": "best_match", "limit": 50]
        
        let baseURL = "https://api.yelp.com/v3/businesses/search"
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(UserDefaults.standard.string(forKey: "token") ?? "")"
        ]
        
        YelpClientService.getBusinesses(url: baseURL, parameters: requestParams, headers: headers) { (receivedCafes) in
            self.allCafeList = receivedCafes
            
            self.yelpIDs = self.allCafeList.map { $0.id }
            
            // Studying Cafes
            RatingService.filterCafesByHastags(yelpIDs: self.yelpIDs, hashtags: ["FastWifi", "LaptopFriendly"], completion: { (filteredIds) in
                
                //filter thru allCafeList according to filteredIds
                //reloadData for corresponding collecView
                
                if let temporaryFilteredIds = filteredIds {
                    self.studyCafeList = self.allCafeList.filter {temporaryFilteredIds.contains($0.id)}
                    
                    self.studyCollectionView?.reloadData()
                    
                } else {
                    
                    
                }
                
            })
            
            // Brunch Cafe
            RatingService.filterCafesByHastags(yelpIDs: self.yelpIDs, hashtags: ["Organic", "Vegan"], completion: { (filteredIds) in
                
                //filter thru allCafeList according to filteredIds
                //reloadData for corresponding collecView
                
                if let temporaryFilteredIds = filteredIds {
                    self.brunchCafeList = self.allCafeList.filter {temporaryFilteredIds.contains($0.id)}
                    
                    self.brunchCollectionView?.reloadData()
                    
                } else {
                    
                    
                }
                
            })
            // Business Cafes
            RatingService.filterCafesByHastags(yelpIDs: self.yelpIDs, hashtags: ["Organic", "Vegan"], completion: { (filteredIds) in
                
                //filter thru allCafeList according to filteredIds
                //reloadData for corresponding collecView
                
                if let temporaryFilteredIds = filteredIds {
                    self.businessCafeList = self.allCafeList.filter {temporaryFilteredIds.contains($0.id)}
                    
                    self.businessCollectionView?.reloadData()
                    
                } else {
                    
                    
                }
                
            })
            // Photography Cafes
            RatingService.filterCafesByHastags(yelpIDs: self.yelpIDs, hashtags: ["Organic", "Vegan"], completion: { (filteredIds) in
                
                //filter thru allCafeList according to filteredIds
                //reloadData for corresponding collecView
                
                if let temporaryFilteredIds = filteredIds {
                    self.photographyCafeList = self.allCafeList.filter {temporaryFilteredIds.contains($0.id)}
                    
                    self.photographyCollectionView?.reloadData()
                    
                } else {
                    
                    
                }
                
            })
    
            

            self.exploreCollectionView?.reloadData()
            
            

            
            
        }
        
        studyCollectionView?.showsHorizontalScrollIndicator = false
        brunchCollectionView?.showsHorizontalScrollIndicator = false
        businessCollectionView?.showsHorizontalScrollIndicator = false
        photographyCollectionView?.showsHorizontalScrollIndicator = false
        exploreCollectionView?.showsHorizontalScrollIndicator = false
        
        automaticallyAdjustsScrollViewInsets = false
        
        
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
    /*func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
     
     let height = self.view.frame.size.height;
     let width = self.view.frame.size.height;
     
     return CGSize(width: width*0.25, height: height*0.25)
     
     //return CGSize(width: width*0.26, height: height*0.26)
     
     //        return CGSize(width: CGFloat((collectionView.frame.size.width / 2) - 20), height: CGFloat(100))
     }*/
    
    @IBAction func unwindToCafeListCollectionViewController(_ segue: UIStoryboardSegue) {
    }
    
    
    
    
    
}



extension CafeListViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == self.studyCollectionView {
            return studyCafeList.count
        }
            
        else if collectionView == self.brunchCollectionView {
            return brunchCafeList.count
        }
            
        else if collectionView == self.businessCollectionView {
            return businessCafeList.count
            
        }
        else if collectionView == self.photographyCollectionView {
            return photographyCafeList.count
        }
            
        else if collectionView == self.exploreCollectionView {
            return allCafeList.count
        }
        
        else {
            return allCafeList.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.studyCollectionView {
            
            let cell:CafeCell = collectionView.dequeueReusableCell(withReuseIdentifier: "studyCafeCell", for: indexPath) as! CafeCell
            
            let cafe = studyCafeList[indexPath.row]
            
            cell.studyCafelabel.text = cafe.name
            
            let imageURL = URL(string: cafe.imageURL)
            cell.studyCafeImage.kf.setImage(with: imageURL)
            
            // Create a subview which will add an overlay effect on image view
            if cell.studyCafeImage.viewWithTag(98) == nil {
                let overlay = UIView(frame: CGRect(x: 0,y: 0,width: cell.studyCafeImage.frame.size.width, height: cell.studyCafeImage.frame.size.height))
                overlay.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.55)
                //0.37
                overlay.tag = 98
                
                //Add the subview to the UIImageView
                cell.studyCafeImage.addSubview(overlay)
            }
            
            return cell
            
        }
        else if collectionView == self.brunchCollectionView {
            
            let cell:CafeCell = collectionView.dequeueReusableCell(withReuseIdentifier: "brunchCafeCell", for: indexPath) as! CafeCell
            
            let cafe = brunchCafeList[indexPath.row]
            
            cell.brunchCafeLabel.text = cafe.name
            
            let imageURL = URL(string: cafe.imageURL)
            cell.brunchCafeImage.kf.setImage(with: imageURL)
            
            // Create a subview which will add an overlay effect on image view
            if cell.brunchCafeImage.viewWithTag(98) == nil {
                let overlay = UIView(frame: CGRect(x: 0,y: 0,width: cell.brunchCafeImage.frame.size.width, height: cell.brunchCafeImage.frame.size.height))
                overlay.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.55)
                //0.37
                overlay.tag = 98
                
                //Add the subview to the UIImageView
                cell.brunchCafeImage.addSubview(overlay)
            }
            
            return cell
            
        }
        else if collectionView == businessCollectionView {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "businessCafeCell", for: indexPath) as! CafeCell
            
            let cafe = businessCafeList[indexPath.row]
            
            cell.businessCafeLabel.text = cafe.name
            
            let imageURL = URL(string: cafe.imageURL)
            cell.businessCafeImage.kf.setImage(with: imageURL)
            
            // Create a subview which will add an overlay effect on image view
            if cell.businessCafeImage.viewWithTag(98) == nil {
                let overlay = UIView(frame: CGRect(x: 0,y: 0,width: cell.businessCafeImage.frame.size.width, height: cell.businessCafeImage.frame.size.height))
                overlay.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.55)
                //0.37
                overlay.tag = 98
                
                //Add the subview to the UIImageView
                cell.businessCafeImage.addSubview(overlay)
            }
            
            return cell
        }
            
    
        else if collectionView == photographyCollectionView {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photographyCafeCell", for: indexPath) as! CafeCell
            
            let cafe = photographyCafeList[indexPath.row]
            
            cell.photographyCafeLabel.text = cafe.name
            
            let imageURL = URL(string: cafe.imageURL)
            cell.photographyCafeImage.kf.setImage(with: imageURL)
            
            // Create a subview which will add an overlay effect on image view
            if cell.photographyCafeImage.viewWithTag(98) == nil {
                let overlay = UIView(frame: CGRect(x: 0,y: 0,width: cell.photographyCafeImage.frame.size.width, height: cell.photographyCafeImage.frame.size.height))
                overlay.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.55)
                //0.37
                overlay.tag = 98
                
                //Add the subview to the UIImageView
                cell.photographyCafeImage.addSubview(overlay)
            }
            
            return cell

        }
            
        
        else {
            
            let cell:CafeCell = collectionView.dequeueReusableCell(withReuseIdentifier: "exploreCafeCell", for: indexPath) as! CafeCell
            
            let cafe = allCafeList[indexPath.row]
            
            cell.exploreCafeLabel.text = cafe.name
            
            let imageURL = URL(string: cafe.imageURL)
            cell.exploreCafeImage.kf.setImage(with: imageURL)
            
            // Create a subview which will add an overlay effect on image view
            if cell.exploreCafeImage.viewWithTag(98) == nil {
                
                let overlay = UIView(frame: CGRect(x: 0,y: 0,width: cell.exploreCafeImage.frame.size.width, height: cell.exploreCafeImage.frame.size.height))
                overlay.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.55)
                //0.37
                overlay.tag = 98
                
                //Add the subview to the UIImageView
                cell.exploreCafeImage.addSubview(overlay)
                
            }
            
            return cell
            
        }
        
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //perform segue and the sender should be the object of the array in the index path
        //TODO
        
        if collectionView == studyCollectionView {
            
            currentCafe = studyCafeList[indexPath.row]
            
        } else if collectionView == brunchCollectionView {
            
            currentCafe = brunchCafeList[indexPath.row]
            
        } else if collectionView == exploreCollectionView {
            
            currentCafe = exploreCafeList[indexPath.row]
        }
            
        performSegue(withIdentifier: "itemSelectedSegue", sender: nil)
    }
    
}
