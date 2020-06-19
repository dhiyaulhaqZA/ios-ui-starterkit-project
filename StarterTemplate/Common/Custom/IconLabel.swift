//
//  IconLabel.swift
//  StarterTemplate
//
//  Created by Dhiya Ulhaq Zulha Alamsyah on 15/10/19.
//  Copyright © 2019 dhiyaulhaqza. All rights reserved.
//

import UIKit

struct IconLabelSize {
    let width: CGFloat
    let height: CGFloat
    let imagePadding: CGFloat
}

enum IconLabelPosition {
    case left, right
}

class IconLabel: UIView {
    
    var icon: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.accessibilityIdentifier = "imageView_iconLabel"
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    var label: UILabel = {
        let label = UILabel(frame: .zero)
        let style = FontStyle.callout
        label.accessibilityIdentifier = "label_iconLabel"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont(name: style.font, size: CGFloat(style.size))
        label.numberOfLines = 0
        label.textAlignment = .left
        label.lineBreakMode = .byTruncatingTail
        label.text = ""
        return label
    }()
    
    init(image: UIImage?, text: String, size: IconLabelSize, position: IconLabelPosition = .left) {
        super.init(frame: .zero)
        icon.image = image
        label.text = text
        setupComponent()
        setupConstraint(size.width, size.height, size.imagePadding, position)
    }
    
    func setLabelStyle(style: FontStyle, color: UIColor, align: NSTextAlignment = NSTextAlignment.left) {
        label.textColor = color
        label.font = UIFont(name: style.font, size: CGFloat(style.size))
        label.numberOfLines = 0
        label.textAlignment = align
        label.lineBreakMode = .byTruncatingTail
    }
    
    private func setupComponent() {
        addSubview(icon)
        addSubview(label)
    }
    
    private func setupConstraint(_ width: CGFloat, _ height: CGFloat, _ imagePadding: CGFloat, _ position: IconLabelPosition) {
        if position == .left {
            NSLayoutConstraint.activate([
                icon.leadingAnchor.constraint(equalTo: leadingAnchor),
                icon.widthAnchor.constraint(equalToConstant: width),
                icon.heightAnchor.constraint(equalToConstant: height),
                icon.topAnchor.constraint(equalTo: topAnchor),
                icon.bottomAnchor.constraint(equalTo: bottomAnchor)
                ])
            
            NSLayoutConstraint.activate([
                label.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: imagePadding),
                label.topAnchor.constraint(equalTo: topAnchor),
                label.bottomAnchor.constraint(equalTo: bottomAnchor),
                label.trailingAnchor.constraint(equalTo: trailingAnchor)
                ])
        } else {
            NSLayoutConstraint.activate([
                icon.trailingAnchor.constraint(equalTo: trailingAnchor),
                icon.widthAnchor.constraint(equalToConstant: width),
                icon.heightAnchor.constraint(equalToConstant: height),
                icon.centerYAnchor.constraint(equalTo: centerYAnchor)
                ])
            
            NSLayoutConstraint.activate([
                label.leadingAnchor.constraint(equalTo: leadingAnchor),
                label.centerYAnchor.constraint(equalTo: centerYAnchor),
                label.trailingAnchor.constraint(equalTo: icon.leadingAnchor, constant: -imagePadding)
                ])
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
