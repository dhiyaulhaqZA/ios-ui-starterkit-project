//
//  DZATextView.swift
//  StarterTemplate
//
//  Created by Dhiya Ulhaq Zulha Alamsyah on 06/02/20.
//  Copyright © 2020 dhiyaulhaqza. All rights reserved.
//

import UIKit

class DZATextView: UITextView, UITextViewDelegate {
    
    var placeHolder: String = ""
    
    convenience init(placeHolder: String) {
        self.init()
        self.placeHolder = placeHolder
        self.text = placeHolder
        if placeHolder == "" {
            self.textColor = UIColor.black
        } else {
            self.textColor = UIColor.disableText
        }
        delegate = self
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.disableText {
            textView.text = ""
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.trim() == "" {
            textView.text = placeHolder
            textView.textColor = UIColor.disableText
        }
    }
}
