//
//  UIViewController+Extension.swift
//  StarterTemplate
//
//  Created by Dhiya Ulhaq Zulha Alamsyah on 07/12/19.
//  Copyright © 2019 dhiyaulhaqza. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func addFakeBackButton() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: R.image.icBack(), style: .plain, target: self, action: #selector(onFakeBackPress(barButton:)))
    }
    
    @objc func onFakeBackPress(barButton: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    func pushViewWhenKeyboardAppears() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func makeRootViewController() {
        let window = UIApplication.shared.delegate?.window
        if let window = window {
            window?.rootViewController = self
            window?.makeKeyAndVisible()
        }
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if #available(iOS 11.0, *) {
                let window = UIApplication.shared.windows.first { $0.isKeyWindow }
                let bottomPadding = window?.safeAreaInsets.bottom ?? 0.0
                let height = keyboardSize.height - bottomPadding
                self.view.frame.origin.y -= height
            } else {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        self.view.frame.origin.y = 0
    }
    
}
