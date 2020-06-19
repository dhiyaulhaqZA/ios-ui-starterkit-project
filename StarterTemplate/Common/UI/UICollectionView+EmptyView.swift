//
//  UICollectionView+EmptyView.swift
//  StarterTemplate
//
//  Created by Dhiya Ulhaq Zulha Alamsyah on 22/01/20.
//  Copyright © 2020 dhiyaulhaqza. All rights reserved.
//

import UIKit

extension UICollectionView {
    
    func setEmptyView(text: String) {
        self.setEmptyView(view: buildUI.label(id: "emptyview", style: .body, color: .gray, align: .center, text: text, numberOfLines: 0), insets: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: -16))
    }
    
    func setEmptyView(view: UIView?, insets: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)) {
        guard let view = view else {
            backgroundView = nil
            return
        }
        
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        containerView.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: containerView.topAnchor, constant: insets.top),
            view.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: insets.left),
            view.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: insets.bottom),
            view.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: insets.right)
        ])
        
        backgroundView = containerView
    }
}
