//
//  CafeLabel.swift
//  CupNSpoon
//
//  Created by Raymond Diamonds on 2017-07-14.
//  Copyright © 2017 Raymond Diamonds. All rights reserved.
//

import UIKit

class CafeLabel: UILabel {
        
        @IBInspectable var iPhoneFontSize:CGFloat = 0 {
            didSet {
                overrideFontSize(fontSize: iPhoneFontSize)
            }
        }
        
        func overrideFontSize(fontSize:CGFloat){
            let currentFontName = self.font.fontName
            var calculatedFont: UIFont?
            let bounds = UIScreen.main.bounds
            let height = bounds.size.height
            switch height {
            case 480.0: //Iphone 3,4,SE => 3.5 inch
                calculatedFont = UIFont(name: currentFontName, size: fontSize * 0.7)
                self.font = calculatedFont
                break
            case 568.0: //iphone 5, 5s => 4 inch
                calculatedFont = UIFont(name: currentFontName, size: fontSize * 0.8)
                self.font = calculatedFont
                break
            case 667.0: //iphone 6, 6s => 4.7 inch
                calculatedFont = UIFont(name: currentFontName, size: fontSize * 0.9)
                self.font = calculatedFont
                break
            case 736.0: //iphone 6s+ 6+ => 5.5 inch
                calculatedFont = UIFont(name: currentFontName, size: fontSize)
                self.font = calculatedFont
                break
            default:
                print("not an iPhone")
                break
            }
            
        }

}
