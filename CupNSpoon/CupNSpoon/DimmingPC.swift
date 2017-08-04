//
//  DimmingPC.swift
//  CupNSpoon
//
//  Created by Raymond Diamonds on 2017-08-04.
//  Copyright © 2017 Raymond Diamonds. All rights reserved.
//

import UIKit

class DimmingPC: UIPresentationController {
    
    //MARK: - Properties
    lazy var dimmingVC = GradientView(frame: CGRect.zero)
    
    //Allows the previous VC to display even with the new controller on top
    override var shouldRemovePresentersView: Bool {
        return false
    }
    
    
    //MARK: - Oerride Methods
    override func presentationTransitionWillBegin() {
        dimmingVC.frame = containerView!.bounds
        containerView!.insertSubview(dimmingVC, at: 0)
        
        dimmingVC.alpha = 0
        if let coordinator = presentedViewController.transitionCoordinator {
            coordinator.animate(alongsideTransition: { _ in self.dimmingVC.alpha = 1 }, completion: nil)
        }
    }
    
    override func dismissalTransitionWillBegin() {
        if let coordinator = presentedViewController.transitionCoordinator {
            coordinator.animate(alongsideTransition: { _ in self.dimmingVC.alpha = 0 }, completion: nil)
        }
    }
}
