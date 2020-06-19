//
//  UIView+Extension.swift
//  StarterTemplate
//
//  Created by Dhiya Ulhaq Zulha Alamsyah on 23/09/19.
//  Copyright © 2019 dhiyaulhaqza. All rights reserved.
//

import UIKit

extension UIView {
    
    func consTop(view: UIView, constant: CGFloat = 0) -> NSLayoutConstraint {
        if #available(iOS 11.0, *) {
            return self.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: constant)
        } else {
            return self.topAnchor.constraint(equalTo: view.topAnchor, constant: constant)
        }
    }
    
    func consBottom(view: UIView, constant: CGFloat = 0) -> NSLayoutConstraint {
        if #available(iOS 11.0, *) {
            return self.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: constant)
        } else {
            return self.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: constant)
        }
    }
    
    func addBluryEffect(style: UIBlurEffect.Style = UIBlurEffect.Style.regular) {
        let blurEffect = UIBlurEffect(style: style)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(blurEffectView)
    }
    
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}
