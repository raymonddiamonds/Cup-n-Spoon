//
//  GradientView.swift
//  CupNSpoon
//
//  Created by Raymond Diamonds on 2017-08-04.
//  Copyright © 2017 Raymond Diamonds. All rights reserved.
//

import UIKit

class GradientView: UIView {
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        autoresizingMask = [.flexibleWidth, .flexibleHeight]
        backgroundColor = .clear
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        autoresizingMask = [.flexibleWidth, .flexibleHeight]
        backgroundColor = .clear
    }
    
    
    //MARK: - Override Methods
    override func draw(_ rect: CGRect) {
        //Contains the color stops; the first color is the first 4 values.
        let components: [CGFloat] = [0, 0, 0, 0.3, 0, 0, 0, 0.7]
        
        //0 is the center and 1 is the outer most of the circle gradient
        let locations: [CGFloat] = [0, 1]
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let gradient = CGGradient(colorSpace: colorSpace, colorComponents: components, locations: locations, count: 2)
        
        let x = bounds.midX
        let y = bounds.midY
        let centerPoint = CGPoint(x: x, y: y)
        let radius = max(x, y)
        
        let context = UIGraphicsGetCurrentContext()
        context?.drawRadialGradient(gradient!, startCenter: centerPoint, startRadius: 0, endCenter: centerPoint, endRadius: radius, options: .drawsAfterEndLocation)
    }
}
