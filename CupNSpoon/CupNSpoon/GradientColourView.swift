//
//  GradientColourView.swift
//  CupNSpoon
//
//  Created by Raymond Diamonds on 2017-08-07.
//  Copyright © 2017 Raymond Diamonds. All rights reserved.
//

import UIKit
import QuartzCore

@IBDesignable
class GradientColourView: UIView {
    
    @IBInspectable var firstColor:UIColor = UIColor.clear
    @IBInspectable var secondColor:UIColor = UIColor.clear
    @IBInspectable var startPoint:CGPoint = CGPoint(x: 0.0, y: 1.0)
    @IBInspectable var endPoint:CGPoint = CGPoint(x: 1.0, y:0.0)
    
    var gradientLayer:CAGradientLayer!
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        gradientLayer = CAGradientLayer()
        self.gradientLayer.colors = [firstColor.cgColor, secondColor.cgColor]
        self.gradientLayer.startPoint = self.startPoint
        self.gradientLayer.endPoint = self.endPoint
        self.gradientLayer.frame = self.frame
        self.layer.addSublayer(self.gradientLayer)
    }
    
    
}
