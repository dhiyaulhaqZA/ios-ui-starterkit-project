//
//  DZAButton.swift
//  StarterTemplate
//
//  Created by Dhiya Ulhaq Zulha Alamsyah on 17/09/19.
//  Copyright © 2019 dhiyaulhaqza. All rights reserved.
//

import UIKit

enum ButtonStyle {
    case smallButton, smallSecondaryButton, normalButton, smallBorderButton, normalBorderButton,
    negativeSmallButton, negativeNormalButton, normalSecondaryButton, normalLightButton
}

class DZAButton: UIButton {
    
    var style: ButtonStyle = .normalButton
    
    func setStyle(style: ButtonStyle) {
        self.style = style
        switch style {
        case .smallButton:
            changeStyleComponent(height: Dimension.init().smallButtonHeight, btnColor:
                .brandSecondary, titleColor: .brandMain)
        case .smallSecondaryButton:
            changeStyleComponent(height: Dimension.init().smallButtonHeight, btnColor:
                .brandSecondary, titleColor: .brandMain)
        case .normalButton:
            changeStyleComponent(height: Dimension.init().normalButtonHeight, btnColor:
                .brandSecondary, titleColor: .brandMain)
        case .smallBorderButton:
            changeStyleComponent(height: Dimension.init().smallButtonHeight, btnColor:
                .white, titleColor: .brandMain, borderColor: .brandMain)
        case .normalBorderButton:
            changeStyleComponent(height: Dimension.init().normalButtonHeight, btnColor:
                .white, titleColor: .brandMain, borderColor: .brandMain)
        case .negativeSmallButton:
            changeStyleComponent(height: Dimension.init().smallButtonHeight, btnColor:
                .white, titleColor: .negative)
        case .negativeNormalButton:
            changeStyleComponent(height: Dimension.init().normalButtonHeight, btnColor:
                .white, titleColor: .negative)
        case .normalSecondaryButton:
            changeStyleComponent(height: Dimension.init().normalButtonHeight, btnColor:
                .brandSecondary, titleColor: .brandMain)
        case .normalLightButton:
            changeStyleComponent(height: Dimension.init().normalButtonHeight, btnColor:
                .white, titleColor: .black)
        }
    }
    
    private func changeStyleComponent(height: Float, btnColor: UIColor? = .white,
                                      titleColor: UIColor? = .blue, borderColor: UIColor? = nil) {
        heightAnchor.constraint(equalToConstant: CGFloat(height)).isActive = true
        backgroundColor = btnColor
        setTitleColor(titleColor, for: .normal)
        if let borderColor = borderColor {
            layer.borderColor = borderColor.cgColor
            layer.masksToBounds = true
            layer.borderWidth = 1.0
        } else {
            layer.borderColor = btnColor?.cgColor
        }
    }
    
    func setEnabled(isEnabled: Bool) {
        self.isEnabled = isEnabled
        if isEnabled {
            setStyle(style: style)
        } else {
            setDisableStyle()
        }
    }
    
    private func setDisableStyle() {
        backgroundColor = .disableBg
        setTitleColor(.disableText, for: .normal)
        layer.borderColor = UIColor.disableBg.cgColor
        if style == .smallBorderButton && style == .normalBorderButton {
            layer.borderColor = UIColor.disableBg.cgColor
        }
    }
    
    func withIcon(image: UIImage?, offset: CGFloat = 16, position: ContentHorizontalAlignment = .left) {
        self.setImage(image, for: .normal)
        if position == .left {
            self.imageEdgeInsets = UIEdgeInsets(top: 0, left: -offset, bottom: 0, right: offset)
        } else if position == .right {
            self.semanticContentAttribute = .forceRightToLeft
            self.imageEdgeInsets = UIEdgeInsets(top: 0, left: offset, bottom: 0, right: -offset)
        }
    }
}
