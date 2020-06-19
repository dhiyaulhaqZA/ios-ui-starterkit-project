//
//  HalfModalTransitionAnimator.swift
//  StarterTemplate
//
//  Created by Dhiya Ulhaq Zulha Alamsyah on 11/11/19.
//  Copyright © 2019 dhiyaulhaqza. All rights reserved.
//

import UIKit

// swiftlint:disable all
class HalfModalTransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    var type: HalfModalTransitionAnimatorType
    
    init(type: HalfModalTransitionAnimatorType) {
        self.type = type
    }
    
    @objc func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let _ = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)
        let from = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: { () -> Void in
            from!.view.frame.origin.y = 800
        }) { (_ ) -> Void in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.4
    }
}

internal enum HalfModalTransitionAnimatorType {
    case present
    case dismiss
}
