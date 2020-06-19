//
//  HalfModalPresentationController.swift
//  StarterTemplate
//
//  Created by Dhiya Ulhaq Zulha Alamsyah on 11/11/19.
//  Copyright © 2019 dhiyaulhaqza. All rights reserved.
//

import UIKit

enum ModalScaleState {
    case adjustedOnce
    case normal
}

// swiftlint:disable all
class HalfModalPresentationController : UIPresentationController {
    var isMaximized: Bool = false
    
    var dimmingViewx: UIView?
    var tapGestureRecognizer: UITapGestureRecognizer
    var panGestureRecognizer: UIPanGestureRecognizer
    var direction: CGFloat = 0
    var state: ModalScaleState = .normal
    var dimmingView: UIView {
        if let dimmedView = dimmingViewx {
            return dimmedView
        }
        let view = UIView(frame: CGRect(x: 0, y: 0, width: containerView!.bounds.width, height: containerView!.bounds.height))
        // Blur Effect
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        view.addSubview(blurEffectView)
        // Vibrancy Effect
        let vibrancyEffect = UIVibrancyEffect(blurEffect: blurEffect)
        let vibrancyEffectView = UIVisualEffectView(effect: vibrancyEffect)
        vibrancyEffectView.frame = view.bounds
        // Add the vibrancy view to the blur view
        blurEffectView.contentView.addSubview(vibrancyEffectView)
        
        dimmingViewx = view
        
        return view
    }
    
    override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
        self.panGestureRecognizer = UIPanGestureRecognizer()
        self.tapGestureRecognizer = UITapGestureRecognizer()
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
        panGestureRecognizer.addTarget(self, action: #selector(onPan(pan:)))
        tapGestureRecognizer.addTarget(self, action: #selector(onTap(tap:)))
        presentedViewController.view.addGestureRecognizer(panGestureRecognizer)
    }
    
    @objc func onTap(tap: UITapGestureRecognizer) -> Void {
        presentedViewController.dismiss(animated: true, completion: nil)
    }
    
    @objc func onPan(pan: UIPanGestureRecognizer) -> Void {
        let endPoint = pan.translation(in: pan.view?.superview)
        
        switch pan.state {
        case .began:
            presentedView!.frame.size.height = containerView!.frame.height
        case .changed:
            let velocity = pan.velocity(in: pan.view?.superview)
            switch state {
            case .normal:
                presentedView!.frame.origin.y = endPoint.y + containerView!.frame.height / 2
            case .adjustedOnce:
                presentedView!.frame.origin.y = endPoint.y
            }
            direction = velocity.y
            
            break
        case .ended:
            if direction < 0 {
                changeScale(to: .adjustedOnce)
            } else {
                if state == .adjustedOnce {
                    changeScale(to: .normal)
                } else {
                    presentedViewController.dismiss(animated: true, completion: nil)
                }
            }
            break
        default:
            break
        }
    }
    
    func changeScale(to state: ModalScaleState) {
        if let presentedView = presentedView, let containerView = self.containerView {
            UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: { () -> Void in
                presentedView.frame = containerView.frame
                let containerFrame = containerView.frame
                let halfFrame = CGRect(origin: CGPoint(x: 0, y: containerFrame.height / 2),
                                       size: CGSize(width: containerFrame.width, height: containerFrame.height / 2))
                let frame = state == .adjustedOnce ? containerView.frame : halfFrame
                presentedView.frame = frame
                if let navController = self.presentedViewController as? UINavigationController {
                    self.isMaximized = true
                    navController.setNeedsStatusBarAppearanceUpdate()
                    // Force the navigation bar to update its size
                    navController.isNavigationBarHidden = true
                    navController.isNavigationBarHidden = false
                }
            }, completion: { (isFinished) in
                self.state = state
            })
        }
    }
    
    override var frameOfPresentedViewInContainerView: CGRect {
        return CGRect(x: 0, y: containerView!.bounds.height / 2, width: containerView!.bounds.width, height: containerView!.bounds.height / 2)
    }
    
    override func presentationTransitionWillBegin() {
        let dimmedView = dimmingView
        if let containerView = self.containerView, let coordinator = presentingViewController.transitionCoordinator {
            
            dimmedView.alpha = 0
            containerView.addSubview(dimmedView)
            dimmedView.addSubview(presentedViewController.view)
            dimmingView.addGestureRecognizer(tapGestureRecognizer)
            coordinator.animate(alongsideTransition: { (context) -> Void in
                dimmedView.alpha = 0.8
                self.presentingViewController.view.transform = CGAffineTransform(scaleX: 1, y: 1)
            }, completion: nil)
        }
    }
    
    override func dismissalTransitionWillBegin() {
        if let coordinator = presentingViewController.transitionCoordinator {
            self.dimmingView.alpha = 0
            self.presentingViewController.view.transform = CGAffineTransform.identity
            coordinator.animate(alongsideTransition: { (context) -> Void in
                self.dimmingView.alpha = 0
                self.presentingViewController.view.transform = CGAffineTransform.identity
            }, completion: { (completed) -> Void in
                
            })
        }
    }
    
    override func dismissalTransitionDidEnd(_ completed: Bool) {
        if completed {
            dimmingView.removeFromSuperview()
            dimmingViewx = nil
            isMaximized = false
        }
    }
}

protocol HalfModalPresentable { }

extension HalfModalPresentable where Self: UIViewController {
    func maximizeToFullScreen() {
        if let presetation = navigationController?.presentationController as? HalfModalPresentationController {
            presetation.changeScale(to: .adjustedOnce)
        }
    }
}

extension HalfModalPresentable where Self: UINavigationController {
    func isHalfModalMaximized() -> Bool {
        if let presentationController = presentationController as? HalfModalPresentationController {
            return presentationController.isMaximized
        }
        return false
    }
}
