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
        cafeList = ["Café Pika","The Humble Lion", "Café St-Laurent", "Not Starbucks"]
        

       collectionView?.backgroundColor = UIColor.blue
        

    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CafeCell
        
        //Configure the cell
        
        let cafe = cafeList[indexPath.row]
        
        cell.cafeName.text = cafe
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        let height = self.view.frame.size.height;
        let width = self.view.frame.size.height;
        
        return CGSize(width: width*0.26, height: height*0.26)
    }
    


}
