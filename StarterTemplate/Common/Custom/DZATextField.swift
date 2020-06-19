//
//  DZATextField.swift
//  StarterTemplate
//
//  Created by Dhiya Ulhaq Zulha Alamsyah on 18/09/19.
//  Copyright © 2019 dhiyaulhaqza. All rights reserved.
//

import UIKit

class DZATextField: UIView {
    
    private let stackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var textField: RoseTextField = {
        return RoseTextField(style: .border)
    }()
    
    let labelMessage: UILabel = {
        let label = buildUI.label(id: "dzatextfield_message",
                                  style: .callout, color: .negative, text: "")
        label.isHidden = true
        return label
    }()
    
    init(style: RoseTextFieldStyle) {
        super.init(frame: .zero)
        textField = RoseTextField(style: style)
        textField.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        addSubview(textField)
        addSubview(labelMessage)
        setupComponent()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupComponent() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            bottomAnchor.constraint(equalTo: stackView.bottomAnchor)])
        
        NSLayoutConstraint.activate([
            textField.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            textField.heightAnchor.constraint(equalToConstant: 40),
            labelMessage.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            labelMessage.trailingAnchor.constraint(equalTo: stackView.trailingAnchor)
            ])
        
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.addArrangedSubview(textField)
        stackView.addArrangedSubview(labelMessage)
    }
    
    func setOnError(message: String?) {
        let isError = message != nil
        labelMessage.isHidden = !isError
        textField.setOnError(isError: isError)
        if isError {
            stackView.addArrangedSubview(labelMessage)
            labelMessage.text = message
        } else {
            stackView.removeArrangedSubview(labelMessage)
            labelMessage.text = ""
        }
    }
}
