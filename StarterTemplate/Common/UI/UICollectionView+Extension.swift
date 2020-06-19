//
//  UICollectionView+Extension.swift
//  StarterTemplate
//
//  Created by Dhiya Ulhaq Zulha Alamsyah on 06/12/19.
//  Copyright © 2019 dhiyaulhaqza. All rights reserved.
//

import UIKit

extension UICollectionViewCell {
    
    func animateCell() {
        self.layer.transform = CATransform3DMakeScale(0.1, 0.1, 1)
        UIView.animate(withDuration: 0.3, animations: {
            self.layer.transform = CATransform3DMakeScale(1.05, 1.05, 1)
        }, completion: { _ in
            UIView.animate(withDuration: 0.1, animations: {
                self.layer.transform = CATransform3DMakeScale(1, 1, 1)
            })
        })
    }
}
