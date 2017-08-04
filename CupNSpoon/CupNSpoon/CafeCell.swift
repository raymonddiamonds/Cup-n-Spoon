//
//  CollectionViewCell.swift
//  Cup'N'Spoon
//
//  Created by Raymond Diamonds on 2017-07-10.
//  Copyright © 2017 Raymond Diamonds. All rights reserved.
//

import UIKit

class CafeCell: UICollectionViewCell {
    
    //MARK: @IBOutlets
    
    @IBOutlet weak var studyCafeImage: UIImageView!
    @IBOutlet weak var studyCafelabel: UILabel!
    
    @IBOutlet weak var brunchCafeImage: UIImageView!
    @IBOutlet weak var brunchCafeLabel: UILabel!
    
    @IBOutlet weak var businessCafeImage: UIImageView!
    @IBOutlet weak var businessCafeLabel: CafeLabel!
    
    @IBOutlet weak var photographyCafeImage: UIImageView!
    @IBOutlet weak var photographyCafeLabel: CafeLabel!
    
    @IBOutlet weak var exploreCafeImage: UIImageView!
    @IBOutlet weak var exploreCafeLabel: CafeLabel!
    
    
    
//    @IBOutlet weak var cafeName: UILabel!
    /*@IBOutlet weak var cafeImage: UIImageView!
    @IBOutlet weak var cafeName: UILabel!
    @IBOutlet weak var cafeAddress: UILabel!*/
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor = UIColor.clear {
        didSet {
            self.layer.borderColor = borderColor.cgColor
        }
    }
    
}
