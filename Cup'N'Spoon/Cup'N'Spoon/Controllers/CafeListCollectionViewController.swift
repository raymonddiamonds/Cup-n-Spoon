//
//  CafeListCollectionViewController.swift
//  Cup'N'Spoon
//
//  Created by Raymond Diamonds on 2017-07-10.
//  Copyright © 2017 Raymond Diamonds. All rights reserved.
//

import UIKit

private let reuseIdentifier = "cafeCell"

class CafeListCollectionViewController: UICollectionViewController,UICollectionViewDelegateFlowLayout {
    
    var cafeList = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //dummy data: list of cafes
        cafeList = ["Café Pika","Café Humble Lion", "Café St-Laurent", "Not Starbucks"]
        
        
//        if let patternImage = UIImage(named: "Image") {
//            view.backgroundColor = UIColor(patternImage: patternImage)
//        }
//
//        collectionView!.backgroundColor = UIColor.clear
//        collectionView!.contentInset = UIEdgeInsets(top: 23, left: 5, bottom: 10, right: 5)
//        
        collectionView?.backgroundColor = UIColor(red:0.96, green:0.95, blue:0.94, alpha:1.0)
        

    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CafeCell
        
        //Configure the cell
        
        if cell.cafeImage.viewWithTag(99) == nil {
            // Create a subview which will add an overlay effect on image view
            let overlay = UIView(frame: CGRect(x: 0,y: 0,width: cell.cafeImage.frame.size.width, height: cell.cafeImage.frame.size.height))
            overlay.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.37);
            overlay.tag = 99
            
            // Add the subview to the UIImageView
            cell.cafeImage.addSubview(overlay)
        }

        //populating cell with Cafe Name from Array
        let cafe = cafeList[indexPath.row]
        
        cell.cafeName.text = cafe
        
        return cell
    }
    
    //dynamically resizing Collecting View cell
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let height = self.view.frame.size.height;
        let width = self.view.frame.size.height;
        
        return CGSize(width: width*0.26, height: height*0.26)
    }
    


}
