//
//  String+Extension.swift
//  StarterTemplate
//
//  Created by Dhiya Ulhaq Zulha Alamsyah on 27/11/19.
//  Copyright © 2019 dhiyaulhaqza. All rights reserved.
//

import Foundation
import UIKit

extension UILabel {
    func setHTMLFromString(htmlText: String) {
        let fontStyle = FontStyle.body
        let modifiedFont = String(format: "<span style=\"font-family: '-apple-system', '\(fontStyle.font)'; font-size: \(fontStyle.size)\">%@</span>", htmlText)
        do {
            let attrStr = try NSAttributedString(
                data: modifiedFont.data(using: .unicode, allowLossyConversion: true)!,
                options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue],
                documentAttributes: nil)
            
            self.attributedText = attrStr
        } catch {
            self.attributedText = NSAttributedString()
        }
    }
}
