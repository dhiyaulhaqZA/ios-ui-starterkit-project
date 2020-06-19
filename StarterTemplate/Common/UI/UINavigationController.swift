//
//  UINavigationController.swift
//  StarterTemplate
//
//  Created by Dhiya Ulhaq Zulha Alamsyah on 14/11/19.
//  Copyright © 2019 dhiyaulhaqza. All rights reserved.
//

import UIKit

extension UINavigationController {
    
    func popsViewController(numberOfLastStacks: Int) {
        let count = viewControllers.count
        let toStack = count - numberOfLastStacks
        for index in stride(from: count - 1, to: toStack, by: -1) {
            viewControllers.remove(at: index)
        }
        popViewController(animated: true)
    }
}
