//
//  UIColor.swift
//  StarterTemplate
//
//  Created by Dhiya Ulhaq Zulha Alamsyah on 14/11/19.
//  Copyright © 2019 dhiyaulhaqza. All rights reserved.
//

import UIKit

extension UIColor {
    
    class var black: UIColor {
        return UIColor(rgb: 0x333D45)
    }
    
    class var brandMain: UIColor {
        return UIColor(rgb: 0x0050AE)
    }
    
    class var brandMainSoft: UIColor {
        return UIColor(rgb: 0x0050AE)
    }
    
    class var brandSecondary: UIColor {
        return UIColor(rgb: 0xFFDE00)
    }
    
    class var disableBg: UIColor {
        return UIColor(rgb: 0xEAEDF0)
    }
    
    class var grayBg: UIColor {
        return UIColor(rgb: 0xF4F5F6)
    }
    
    class var disableText: UIColor {
        return UIColor(rgb: 0x8C939D)
    }
    
    class var negative: UIColor {
        return UIColor(rgb: 0xE7475E)
    }
    
    class var positive: UIColor {
        return UIColor(rgb: 0x27AE60)
    }
    
    class var darkBluishGray: UIColor {
        return UIColor(rgb: 0x333D45)
    }
    
    class var softBlueBg: UIColor {
        return UIColor(rgb: 0xDAE8F7)
    }
    
    class var star: UIColor {
        return UIColor(rgb: 0xFFC107)
    }
}

extension UIColor {
    
    public convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    public convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
}
