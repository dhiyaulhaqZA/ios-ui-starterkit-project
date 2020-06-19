//
//  DZAEmptyView.swift
//  StarterTemplate
//
//  Created by Dhiya Ulhaq Zulha Alamsyah on 24/01/20.
//  Copyright © 2020 dhiyaulhaqza. All rights reserved.
//

import UIKit

class DZAEmptyView: UIView {
    
    let container: UIView = {
        return buildUI.container(id: "emptyView")
    }()
    
    let imageView: UIImageView = {
        return buildUI.imageView(id: "emptyView", image: nil)
    }()
    
    let labelTitle: UILabel = {
        return buildUI.label(id: "emptyView", style: .headline, color: .black, align: .center, text: "", numberOfLines: 0)
    }()
    
    let labelSubTitle: UILabel = {
        return buildUI.label(id: "emptyView", style: .callout, color: .gray, align: .center, text: "", numberOfLines: 0)
    }()

    init(image: UIImage?, title: String, subtitle: String = "") {
        super.init(frame: .zero)
        setupComponent()
        setupConstraint()
        setupData(image: image, title: title, subtitle: subtitle)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupComponent() {
        addSubview(container)
        container.addSubview(imageView)
        container.addSubview(labelTitle)
        container.addSubview(labelSubTitle)
    }
    
    private func setupConstraint() {
        NSLayoutConstraint.activate([
            container.widthAnchor.constraint(equalTo: widthAnchor),
            container.centerXAnchor.constraint(equalTo: centerXAnchor),
            container.centerYAnchor.constraint(equalTo: centerYAnchor),
            container.bottomAnchor.constraint(equalTo: labelSubTitle.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: container.topAnchor),
            imageView.widthAnchor.constraint(equalTo: container.widthAnchor, multiplier: 0.50),
            imageView.heightAnchor.constraint(equalTo: container.widthAnchor, multiplier: 0.50),
            imageView.centerXAnchor.constraint(equalTo: container.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            labelTitle.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16),
            labelTitle.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 16),
            labelTitle.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            labelSubTitle.topAnchor.constraint(equalTo: labelTitle.bottomAnchor, constant: 8),
            labelSubTitle.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 16),
            labelSubTitle.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -16)
        ])
    }
    
    func setupData(image: UIImage?, title: String, subtitle: String = "") {
        imageView.image = image
        labelTitle.text = title
        labelSubTitle.text = subtitle
    }
}
