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
import CoreLocation

class CafeListViewController: UIViewController, CLLocationManagerDelegate{
    
    
    @IBOutlet weak var studyCollectionView: UICollectionView!
    @IBOutlet weak var brunchCollectionView: UICollectionView!
    @IBOutlet weak var brunchEmptyView: UIView!
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
    
    var currentLocation: CLLocation?
    let locationManager = CLLocationManager()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            currentLocation = locationManager.location
        } else {
            
        }
        

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
        let requestParams: Parameters = ["term": "cafe", "latitude": currentLocation?.coordinate.latitude, "longitude": currentLocation?.coordinate.longitude , "sort_by": "best_match", "limit": 50]
        
        //"latitude": currentLocation?.coordinate.latitude, "longitude": currentLocation?.coordinate.longitude
        
        let baseURL = "https://api.yelp.com/v3/businesses/search"
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(UserDefaults.standard.string(forKey: "token") ?? "")"
        ]
        print("will send get businesses from Yelp \(Date())")
        YelpClientService.getBusinesses(url: baseURL, parameters: requestParams, headers: headers) { (receivedCafes) in
            self.allCafeList = receivedCafes
            
            self.yelpIDs = self.allCafeList.map { $0.id }
            print("businesses returned from Yelp \(Date())")
            
            // Studying Cafes
            RatingService.filterCafesByHastags(yelpIDs: self.yelpIDs, hashtags: ["FastWifi", "LaptopFriendly"], completion: { (filteredIds) in
                
                print("hashtags returned from firebase (study) \(Date())")
                
                //filter thru allCafeList according to filteredIds
                //reloadData for corresponding collecView
                
                if let temporaryFilteredIds = filteredIds {
                    self.studyCafeList = self.allCafeList.filter {temporaryFilteredIds.contains($0.id)}
                    print("hashtags filtered (study) \(Date())")
                    DispatchQueue.main.async {
                        self.studyCollectionView?.reloadData()
                    }
                } else {
                    
                    
                }
                
            })
            
            // Brunch Cafe
            RatingService.filterCafesByHastags(yelpIDs: self.yelpIDs, hashtags: ["Brunch"], completion: { (filteredIds) in
                print("hashtags returned from firebase (brunch) \(Date())")
                
                //filter thru allCafeList according to filteredIds
                //reloadData for corresponding collecView
                
                if let temporaryFilteredIds = filteredIds {
                    self.brunchCafeList = self.allCafeList.filter {temporaryFilteredIds.contains($0.id)}
                    print("hashtags filtered (brunch) \(Date())")
                    
                    self.brunchCollectionView?.reloadData()
                    //self.brunchEmptyView.isHidden = !self.brunchCafeList.isEmpty
                    
                } else {
                    
                    
                }
                
            })
            // Business Cafes
            RatingService.filterCafesByHastags(yelpIDs: self.yelpIDs, hashtags: ["FreeWifi"], completion: { (filteredIds) in
                print("hashtags returned from firebase (business) \(Date())")
                
                //filter thru allCafeList according to filteredIds
                //reloadData for corresponding collecView
                
                if let temporaryFilteredIds = filteredIds {
                    self.businessCafeList = self.allCafeList.filter {temporaryFilteredIds.contains($0.id)}
                    print("hashtags filtered (business) \(Date())")
                    
                    self.businessCollectionView?.reloadData()
                    
                } else {
                    
                    
                }
                
            })
            // Photography Cafes
            RatingService.filterCafesByHastags(yelpIDs: self.yelpIDs, hashtags: ["Aesthetic"], completion: { (filteredIds) in
                print("hashtags returned from firebase (photo) \(Date())")
                
                //filter thru allCafeList according to filteredIds
                //reloadData for corresponding collecView
                
                if let temporaryFilteredIds = filteredIds {
                    self.photographyCafeList = self.allCafeList.filter {temporaryFilteredIds.contains($0.id)}
                    print("hashtags filtered (photo) \(Date())")
                    
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
    
    
    // If we have been deined access give the user the option to change it
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if(status == CLAuthorizationStatus.denied) {
            showLocationDisabledPopUp()
        }
    }
    
    // Show the popup to the user if we have been deined access
    func showLocationDisabledPopUp() {
        let alertController = UIAlertController(title: "Location Access Disabled",
                                                message: "In order to locate nearby cafes, we need your location",
                                                preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        //alertController.addAction(cancelAction)
        
        let openAction = UIAlertAction(title: "Open Settings", style: .default) { (action) in
            if let url = URL(string: UIApplicationOpenSettingsURLString) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
        alertController.addAction(openAction)
        
        self.present(alertController, animated: true, completion: nil)
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
     
     return CGSize(width: width*0.22, height: height*0.23)
     
     //return CGSize(width: width*0.26, height: height*0.26)
     
     //        return CGSize(width: CGFloat((collectionView.frame.size.width / 2) - 20), height: CGFloat(100))
     }
    
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
        
        var cell: CafeCell
        var cafe: Cafe
        
        if collectionView == self.studyCollectionView {
            
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "studyCafeCell", for: indexPath) as! CafeCell
            
            cafe = studyCafeList[indexPath.row]
            
            cell.studyCafelabel.text = cafe.name
            
            let imageURL = URL(string: cafe.imageURL.replacingOccurrences(of: "o.jpg", with: "ms.jpg"))
            //cell.studyCafeImage.kf.setImage(with: imageURL)
            cell.studyCafeImage.kf.setImage(with: imageURL, placeholder: nil, options: nil, progressBlock: nil, completionHandler: { (image) in
                print("image downloaded for study cell \(Date())")
            })
            
            return cell
            
        }
        else if collectionView == self.brunchCollectionView {
            
            let cell:CafeCell = collectionView.dequeueReusableCell(withReuseIdentifier: "brunchCafeCell", for: indexPath) as! CafeCell
            
            let cafe = brunchCafeList[indexPath.row]
            
            cell.brunchCafeLabel.text = cafe.name
            
            let imageURL = URL(string: cafe.imageURL.replacingOccurrences(of: "o.jpg", with: "ms.jpg"))
            cell.brunchCafeImage.kf.setImage(with: imageURL, placeholder: nil, options: nil, progressBlock: nil, completionHandler: { (image) in
                print("image downloaded for brunch cell \(Date())")
            })
            
            return cell
            
        }
        else if collectionView == businessCollectionView {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "businessCafeCell", for: indexPath) as! CafeCell
            
            let cafe = businessCafeList[indexPath.row]
            
            cell.businessCafeLabel.text = cafe.name
            
            let imageURL = URL(string: cafe.imageURL.replacingOccurrences(of: "o.jpg", with: "ms.jpg"))
            cell.businessCafeImage.kf.setImage(with: imageURL, placeholder: nil, options: nil, progressBlock: nil, completionHandler: { (image) in
                print("image downloaded for business cell \(Date())")
            })
            
            return cell
        }
            
            
        else if collectionView == photographyCollectionView {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photographyCafeCell", for: indexPath) as! CafeCell
            
            let cafe = photographyCafeList[indexPath.row]
            
            
            cell.photographyCafeLabel.text = cafe.name
            
            let imageURL = URL(string: cafe.imageURL.replacingOccurrences(of: "o.jpg", with: "ms.jpg"))
            cell.photographyCafeImage.kf.setImage(with: imageURL, placeholder: nil, options: nil, progressBlock: nil, completionHandler: { (image) in
                print("image downloaded for photo cell \(Date())")
            })
            
            return cell
            
        }
            
            
        else {
            
            let cell:CafeCell = collectionView.dequeueReusableCell(withReuseIdentifier: "exploreCafeCell", for: indexPath) as! CafeCell
            
            let cafe = allCafeList[indexPath.row]
            
            cell.exploreCafeLabel.text = cafe.name
            
            let imageURL = URL(string: cafe.imageURL.replacingOccurrences(of: "o.jpg", with: "ms.jpg"))
            cell.exploreCafeImage.kf.setImage(with: imageURL)
            
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
            
        } else if collectionView == businessCollectionView {
            
            currentCafe = businessCafeList[indexPath.row]
            
        } else if collectionView == photographyCollectionView {
            
            currentCafe = photographyCafeList[indexPath.row]
            
        } else {
            
            currentCafe = allCafeList[indexPath.row]
            
        }
        
        performSegue(withIdentifier: "itemSelectedSegue", sender: nil)
    }
    
}
