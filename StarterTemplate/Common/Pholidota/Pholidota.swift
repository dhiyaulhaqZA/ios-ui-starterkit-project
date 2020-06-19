//
//  Pholidota.swift
//  StarterTemplate
//
//  Created by Dhiya Ulhaq Zulha Alamsyah on 25/10/19.
//  Copyright © 2019 dhiyaulhaqza. All rights reserved.
//

import UIKit

open class Pholidota {
    
    private var containerView = UIView()
    private var progressView = UIView()
    private var activityIndicator = UIActivityIndicatorView()
    
    private static let shared = Pholidota()
    
    static func show(isShow: Bool, viewIfNeeded: UIView? = nil) {
        if isShow {
            shared.showProgressView(view: viewIfNeeded)
        } else {
            shared.hideProgressView()
        }
    }
    
    private func showProgressView(view: UIView? = nil) {
        if let view = view {
            containerView.frame = view.frame
            containerView.center = view.center
            
            progressView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
            progressView.center = view.center
        } else {
            let window = UIWindow(frame: UIScreen.main.bounds)
            containerView.frame = window.frame
            containerView.center = window.center
            
            progressView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
            progressView.center = window.center
        }
        
        containerView.backgroundColor = UIColor(hex: 0xffffff, alpha: 0.3)
        
        progressView.backgroundColor = UIColor(hex: 0x444444, alpha: 0.7)
        progressView.clipsToBounds = true
        progressView.layer.cornerRadius = 10
        
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        activityIndicator.style = UIActivityIndicatorView.Style.large
        activityIndicator.center = CGPoint(x: progressView.bounds.width / 2, y: progressView.bounds.height / 2)
        
        progressView.addSubview(activityIndicator)
        containerView.addSubview(progressView)
        (UIApplication.shared.windows.first { $0.isKeyWindow })?.addSubview(containerView)
        
        activityIndicator.startAnimating()
    }
    
    private func hideProgressView() {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.containerView.removeFromSuperview()
        }
    }
}

fileprivate extension UIColor {
    convenience init(hex: UInt32, alpha: CGFloat) {
        let red = CGFloat((hex & 0xFF0000) >> 16)/256.0
        let green = CGFloat((hex & 0xFF00) >> 8)/256.0
        let blue = CGFloat(hex & 0xFF)/256.0
        
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}
