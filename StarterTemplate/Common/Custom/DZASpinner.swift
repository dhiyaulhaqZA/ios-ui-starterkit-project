//
//  DZASpinner.swift
//  StarterTemplate
//
//  Created by Dhiya Ulhaq Zulha Alamsyah on 19/11/19.
//  Copyright © 2019 dhiyaulhaqza. All rights reserved.
//

import UIKit

class DZASpinner: UIView {
    
    let textField: DZATextField = {
        return buildUI.textField(id: "dzaSpinner_field", style: .spinner)
    }()
    
    let imageView: UIImageView = {
        return buildUI.imageView(id: "dzaSpinner_dropDown", image: R.image.icBottomArrow())
    }()
    
    let pickerView: UIPickerView = {
        let picker = UIPickerView()
        picker.accessibilityIdentifier = "picker_dzaSpinner_picker"
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()
    
    init(delegate: UIPickerViewDelegate & UIPickerViewDataSource) {
        super.init(frame: .zero)
        setupComponent()
        setupConstraint()
        pickerView.dataSource = delegate
        pickerView.delegate = delegate
        
        textField.textField.inputView = pickerView
    }
    
    private func setupComponent() {
        addSubview(textField)
        textField.addSubview(imageView)
    }
    
    func setText(title: String) {
        textField.textField.text = title
    }
    
    private func setupConstraint() {
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: topAnchor),
            textField.leadingAnchor.constraint(equalTo: leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor)
            ])
        
        NSLayoutConstraint.activate([
            imageView.centerYAnchor.constraint(equalTo: textField.centerYAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            imageView.widthAnchor.constraint(equalToConstant: 32),
            imageView.heightAnchor.constraint(equalToConstant: 32)
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
