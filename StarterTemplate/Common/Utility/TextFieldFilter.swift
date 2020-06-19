//
//  TextFieldFilter.swift
//  StarterTemplate
//
//  Created by Dhiya Ulhaq Zulha Alamsyah on 24/09/19.
//  Copyright © 2019 dhiyaulhaqza. All rights reserved.
//

import UIKit

class TextFieldFilter {
    static func input(textField: UITextField? = nil, range: NSRange? = nil,
                      string: String, inputType: InputType) -> Bool {
        var filterOnly = ""
        switch inputType {
        case .alphabetWhiteSpace:
            filterOnly = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLKMNOPQRSTUVWXYZ "
        case .phoneNumber:
            filterOnly = "+1234567890"
        case .number:
            filterOnly = "0123456789"
        case .email:
            return string.rangeOfCharacter(from: .uppercaseLetters) == nil
        default:
            return true
        }
        
        let allowedCharacters = CharacterSet(charactersIn: filterOnly)
        let characterSet = CharacterSet(charactersIn: string)
        return allowedCharacters.isSuperset(of: characterSet)
    }
}
