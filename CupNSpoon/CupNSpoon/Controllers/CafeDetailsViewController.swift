//
//  CafeDetailsViewController.swift
//  CupNSpoon
//
//  Created by Raymond Diamonds on 2017-07-13.
//  Copyright © 2017 Raymond Diamonds. All rights reserved.
//

import UIKit
import FontAwesome_swift

class CafeDetailsViewController: UIViewController {
    
    @IBOutlet weak var backgroundPic: UIImageView!
    @IBOutlet weak var phoneButton: UIButton!
    
    @IBOutlet weak var addressDetails: UILabel!
    var cafe: Cafe?
    var phoneNum: String = ""
    var imageURL: String = ""
    

    override func viewDidLoad() {
        super.viewDidLoad()
        

        
        if let currentCafe = cafe {
            print(currentCafe.address)
            
            addressDetails.text = currentCafe.address
            phoneNum = currentCafe.phoneNum
            imageURL = currentCafe.imageURL
        }
        else {
            print("is nil")
        }
        
        let backgroundPicURL = URL(string: self.imageURL)
        backgroundPic.kf.setImage(with: backgroundPicURL)
        
        phoneButton.titleLabel?.font = UIFont.fontAwesome(ofSize: 32)
        phoneButton.setTitle(String.fontAwesomeIcon(name: .phone), for: .normal)
        
        if let url = URL(string: phoneNum), UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
        
        
        
        
    }
    


}
