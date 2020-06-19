//
//  UITextField+Extension.swift
//  StarterTemplate
//
//  Created by Dhiya Ulhaq Zulha Alamsyah on 24/09/19.
//  Copyright © 2019 dhiyaulhaqza. All rights reserved.
//

import UIKit

extension UITextField {
    
    func setInputAccessoryView() {
        let toolbar = UIToolbar()
        toolbar.barStyle = .default
        toolbar.isTranslucent = false
        toolbar.sizeToFit()
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneBtn = buildUI.buttonText(id: "keyboardToolbar_done", title: "Done", fontStyle: .headline, color: .systemBlue)
        doneBtn.addTarget(self, action: #selector(UIView.endEditing(_:)), for: .touchUpInside)
        let doneButton = UIBarButtonItem(customView: doneBtn)
        toolbar.setItems([spaceButton, doneButton], animated: false)
        toolbar.isUserInteractionEnabled = true
        toolbar.layoutIfNeeded()
        inputAccessoryView = toolbar
    }
}
