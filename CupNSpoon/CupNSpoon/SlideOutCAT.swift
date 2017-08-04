//
//  SlideOutCAT.swift
//  CupNSpoon
//
//  Created by Raymond Diamonds on 2017-08-04.
//  Copyright © 2017 Raymond Diamonds. All rights reserved.
//

import UIKit

class SlideOutCAT: NSObject, UIViewControllerAnimatedTransitioning {
    
    //MARK: - Methods
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    
    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        if let fromView = transitionContext.view(forKey: .from) {
            
            let containerView = transitionContext.containerView
            let duration = transitionDuration(using: transitionContext)
            UIView.animate(withDuration: duration, animations: {
                fromView.center.y -= containerView.bounds.size.height
                fromView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
                
            }, completion: { finished in
                transitionContext.completeTransition(finished)
            })
        }
    }
}
