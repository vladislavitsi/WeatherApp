//
//  SearchViewAnimator.swift
//  WeatherApp
//
//  Created by Uladzislau Kleshchanka on Aug/03/2018.
//  Copyright © 2018 Uladzislau Kleshchanka. All rights reserved.
//

import UIKit

class SearchViewAnimator: NSObject, UIViewControllerAnimatedTransitioning, UIViewControllerInteractiveTransitioning {
    
    
    func startInteractiveTransition(_ transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        let toView = transitionContext.view(forKey: .to)
        let searchView = presenting ? toView! : transitionContext.view(forKey: .from)!
        
        let initialFrame = presenting ? originFrame : searchView.frame
        let finalFrame = presenting ? searchView.frame : originFrame
        
        let xScaleFactor = presenting ?
            initialFrame.width / finalFrame.width :
            finalFrame.width / initialFrame.width
        
        let yScaleFactor = presenting ?
            initialFrame.height / finalFrame.height :
            finalFrame.height / initialFrame.height
        
        let scaleTransform = CGAffineTransform(scaleX: xScaleFactor, y: yScaleFactor)
        
        if presenting {
            searchView.transform = scaleTransform
            searchView.center = CGPoint(
                x: initialFrame.midX,
                y: initialFrame.midY)
            searchView.clipsToBounds = true
        }
        
        if presenting {
            containerView.addSubview(toView!)
        }
        containerView.bringSubview(toFront: searchView)
        
        UIView.animate(withDuration: duration, delay:0.0,
                       usingSpringWithDamping: 1, initialSpringVelocity: 0.0,
                       animations: {
                        searchView.transform = self.presenting ? CGAffineTransform.identity : scaleTransform
                        searchView.center = CGPoint(x: finalFrame.midX, y: finalFrame.midY)
        }, completion: { _ in
            if !self.presenting {
                self.dismissCompletion?()
            }
            transitionContext.finishInteractiveTransition()
        })

    }
    
    
    
    let duration = 0.3
    var presenting = true
    var originFrame = CGRect.zero
    var dismissCompletion: (()->Void)?
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        let toView = transitionContext.view(forKey: .to)
        let searchView = presenting ? toView! : transitionContext.view(forKey: .from)!
        
        let initialFrame = presenting ? originFrame : searchView.frame
        let finalFrame = presenting ? searchView.frame : originFrame

        let xScaleFactor = presenting ?
            initialFrame.width / finalFrame.width :
            finalFrame.width / initialFrame.width
        
        let yScaleFactor = presenting ?
            initialFrame.height / finalFrame.height :
            finalFrame.height / initialFrame.height
        
        let scaleTransform = CGAffineTransform(scaleX: xScaleFactor, y: yScaleFactor)
        
        if presenting {
            searchView.transform = scaleTransform
            searchView.center = CGPoint(
                x: initialFrame.midX,
                y: initialFrame.midY)
            searchView.clipsToBounds = true
        }
        
        if presenting {
            containerView.addSubview(toView!)
        }
        containerView.bringSubview(toFront: searchView)
        
        UIView.animate(withDuration: duration, delay:0.0,
                       usingSpringWithDamping: 1, initialSpringVelocity: 0.0,
                       animations: {
                        searchView.transform = self.presenting ? CGAffineTransform.identity : scaleTransform
                        searchView.center = CGPoint(x: finalFrame.midX, y: finalFrame.midY)
        }, completion: { _ in
            if !self.presenting {
                self.dismissCompletion?()
            }
            transitionContext.completeTransition(true)
        })

    }
    
}
