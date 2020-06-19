//
//  HomeItemCell.swift
//  StarterTemplate
//
//  Created by Dhiya Ulhaq Zulha Alamsyah on 13/06/20.
//  Copyright © 2020 dhiyaulhaqza. All rights reserved.
//

import UIKit

class HomeItemCell: UICollectionViewCell {

    let containerCardView: UIView = {
        return buildUI.cardView(id: "homeItemCell_container")
    }()
    
    let titleLabel: UILabel = {
        let label = buildUI.label(id: "homeItemCell_title", style: .title3, color: .black, align: .left, text: "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod", numberOfLines: 1)
        
        return label
    }()
    
    let descriptionLabel: UILabel = {
        return buildUI.label(id: "homeItemCell_description", style: .body, color: .black, align: .left, text: "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam", numberOfLines: 2)
    }()
    
    lazy var width: NSLayoutConstraint = {
        let width = contentView.widthAnchor.constraint(equalToConstant: bounds.size.width)
        width.isActive = true
        return width
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupComponent()
        setupConstraint()
    }

    private func setupComponent() {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(containerCardView)
        containerCardView.addSubview(titleLabel)
        containerCardView.addSubview(descriptionLabel)
    }

    private func setupConstraint() {
        NSLayoutConstraint.activate([
            containerCardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            containerCardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            containerCardView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            containerCardView.bottomAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 8)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: containerCardView.leadingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: containerCardView.trailingAnchor, constant: -8),
            titleLabel.topAnchor.constraint(equalTo: containerCardView.topAnchor, constant: 8)
        ])
        
        NSLayoutConstraint.activate([
            descriptionLabel.leadingAnchor.constraint(equalTo: containerCardView.leadingAnchor, constant: 8),
            descriptionLabel.trailingAnchor.constraint(equalTo: containerCardView.trailingAnchor, constant: -8),
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8)
        ])
        
        contentView.bottomAnchor.constraint(equalTo: containerCardView.bottomAnchor, constant: 4).isActive = true
    }

    override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {
        width.constant = bounds.size.width
        return contentView.systemLayoutSizeFitting(CGSize(width: targetSize.width, height: 1))
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
