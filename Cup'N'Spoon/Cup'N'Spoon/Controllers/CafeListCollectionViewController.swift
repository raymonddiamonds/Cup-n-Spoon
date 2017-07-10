//
//  CafeListCollectionViewController.swift
//  Cup'N'Spoon
//
//  Created by Raymond Diamonds on 2017-07-10.
//  Copyright © 2017 Raymond Diamonds. All rights reserved.
//

import UIKit

private let reuseIdentifier = "cafeCell"

class CafeListCollectionViewController: UICollectionViewController {
    
    var cafeList = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cafeList = ["Café Pika","The Humble Lion", "Café St-Laurent", "Not Starbucks"]
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

}
