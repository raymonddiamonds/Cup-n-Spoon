//
//  RatingViewController.swift
//  CupNSpoon
//
//  Created by Raymond Diamonds on 2017-07-25.
//  Copyright © 2017 Raymond Diamonds. All rights reserved.
//

import UIKit

class RatingViewController: UIViewController {
    
    var cafe: Cafe?
    
    @IBOutlet var tagButton: [RoundButton]!
    
    
    var selectedHash = [String]()
    
    @IBOutlet weak var reviewInfoText: UILabel!
    
    @IBAction func selectedHash(_ sender: UIButton) {
        
        sender.isSelected = !sender.isSelected
        
        if sender.isSelected == true {
            sender.layer.borderWidth = 0
            
            selectedHash.append(sender.currentTitle!)
            
        } else {
            sender.layer.borderWidth = 1
            selectedHash.remove(at: selectedHash.index(of: sender.currentTitle!)!)
        }
    }
    
    @IBAction func submitButtonPressed(_ sender: RoundButton) {
        guard let yelpID = cafe?.id else { return }
        RatingService.create(hashtags: selectedHash, yelpID: yelpID, completion: { [unowned self] () in
            self.performSegue(withIdentifier: "hashtagsSubmitted", sender: self)
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
       reviewInfoText.text = "Share your experiences with the community by selecting relevant hashtags that represents your time at \(cafe!.name)"
        
        for button in tagButton {
            button.titleLabel?.adjustsFontSizeToFitWidth = true

        }

    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        modalPresentationStyle = .custom
        transitioningDelegate = self
    }




}

extension RatingViewController: UIViewControllerTransitioningDelegate {
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return DimmingPC(presentedViewController: presented, presenting: presenting)
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        return BounceCAT()
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        return SlideOutCAT()
    }
    
}
