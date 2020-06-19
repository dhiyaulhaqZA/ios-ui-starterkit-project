//
//  OtpTextField.swift
//  StarterTemplate
//
//  Created by Dhiya Ulhaq Zulha Alamsyah on 23/09/19.
//  Copyright © 2019 dhiyaulhaqza. All rights reserved.
//

import UIKit

protocol OtpTextFieldDelegate: class {
    func onOtpTextFieldEditingChanged(otpCode: String)
}

class OtpTextField: UIView, UITextFieldDelegate {
    
    weak var delegate: OtpTextFieldDelegate?
    
    let textField1: RoseTextField = {
        let otpTextField = RoseTextField(style: .border)
        let style: FontStyle = .title1
        otpTextField.textAlignment = .center
        otpTextField.font = UIFont(name: style.font, size: CGFloat(style.size))
        otpTextField.textColor = .white
        otpTextField.backgroundColor = UIColor.grayBg.withAlphaComponent(0.50)
        otpTextField.translatesAutoresizingMaskIntoConstraints = false
        return otpTextField
    }()
    
    let textField2: RoseTextField = {
        let otpTextField = RoseTextField(style: .border)
        let style: FontStyle = .title1
        otpTextField.textAlignment = .center
        otpTextField.font = UIFont(name: style.font, size: CGFloat(style.size))
        otpTextField.textColor = .white
        otpTextField.backgroundColor = UIColor.grayBg.withAlphaComponent(0.50)
        otpTextField.translatesAutoresizingMaskIntoConstraints = false
        return otpTextField
    }()
    
    let textField3: RoseTextField = {
        let otpTextField = RoseTextField(style: .border)
        let style: FontStyle = .title1
        otpTextField.textAlignment = .center
        otpTextField.font = UIFont(name: style.font, size: CGFloat(style.size))
        otpTextField.textColor = .white
        otpTextField.backgroundColor = UIColor.grayBg.withAlphaComponent(0.50)
        otpTextField.translatesAutoresizingMaskIntoConstraints = false
        return otpTextField
    }()
    
    let textField4: RoseTextField = {
        let otpTextField = RoseTextField(style: .border)
        let style: FontStyle = .title1
        otpTextField.textAlignment = .center
        otpTextField.font = UIFont(name: style.font, size: CGFloat(style.size))
        otpTextField.textColor = .white
        otpTextField.backgroundColor = UIColor.grayBg.withAlphaComponent(0.50)
        otpTextField.translatesAutoresizingMaskIntoConstraints = false
        return otpTextField
    }()
    
    let labelMessage: UILabel = {
        let label = buildUI.label(id: "otpTextField_message", style: .callout,
                                  color: .negative, align: .center, text: "")
        label.isHidden = true
        return label
    }()
    
    let stackViewContainer: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let stackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupComponent()
        setupConstraint()
    }
    
    private func setupComponent() {
        addSubview(textField1)
        addSubview(textField2)
        addSubview(textField3)
        addSubview(textField4)
        addSubview(labelMessage)
        addSubview(stackView)
        addSubview(stackViewContainer)
        
        textField1.keyboardType = .numberPad
        textField2.keyboardType = .numberPad
        textField3.keyboardType = .numberPad
        textField4.keyboardType = .numberPad
        
        textField1.delegate = self
        textField2.delegate = self
        textField3.delegate = self
        textField4.delegate = self
        
        textField1.addTarget(self, action: #selector(onTextFieldEditingChanged(textField:)), for: .editingChanged)
        textField2.addTarget(self, action: #selector(onTextFieldEditingChanged(textField:)), for: .editingChanged)
        textField3.addTarget(self, action: #selector(onTextFieldEditingChanged(textField:)), for: .editingChanged)
        textField4.addTarget(self, action: #selector(onTextFieldEditingChanged(textField:)), for: .editingChanged)
    }
    
    private func setupConstraint() {
        NSLayoutConstraint.activate([
            stackViewContainer.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackViewContainer.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackViewContainer.topAnchor.constraint(equalTo: topAnchor),
            stackViewContainer.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: stackViewContainer.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: stackViewContainer.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: stackViewContainer.topAnchor)
            ])
        
        NSLayoutConstraint.activate([
            textField1.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 0.20),
            textField2.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 0.20),
            textField3.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 0.20),
            textField4.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 0.20),
            textField1.heightAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 0.20),
            textField2.heightAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 0.20),
            textField3.heightAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 0.20),
            textField4.heightAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 0.20)
            ])
        
        NSLayoutConstraint.activate([
            labelMessage.centerXAnchor.constraint(equalTo: stackViewContainer.centerXAnchor),
            labelMessage.leadingAnchor.constraint(equalTo: stackViewContainer.leadingAnchor),
            labelMessage.trailingAnchor.constraint(equalTo: stackViewContainer.trailingAnchor)
            ])
        
        stackView.distribution = .equalSpacing
        stackView.axis = .horizontal
        stackView.addArrangedSubview(textField1)
        stackView.addArrangedSubview(textField2)
        stackView.addArrangedSubview(textField3)
        stackView.addArrangedSubview(textField4)
        
        stackViewContainer.axis = .vertical
        stackViewContainer.spacing = 16
        stackViewContainer.addArrangedSubview(stackView)
    }
    
    func setOnError(message: String?) {
        let isError = message != nil
        labelMessage.isHidden = !isError
        textField1.setOnError(isError: isError)
        textField2.setOnError(isError: isError)
        textField3.setOnError(isError: isError)
        textField4.setOnError(isError: isError)
        if isError {
            stackViewContainer.addArrangedSubview(labelMessage)
            labelMessage.text = message
        } else {
            stackViewContainer.removeArrangedSubview(labelMessage)
            labelMessage.text = ""
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func onTextFieldEditingChanged(textField: UITextField) {
        let text = textField.text
        if text?.utf16.count ?? 0 >= 1 {
            switch textField {
            case textField1:
                textField2.becomeFirstResponder()
            case textField2:
                textField3.becomeFirstResponder()
            case textField3:
                textField4.becomeFirstResponder()
            case textField4:
                textField4.resignFirstResponder()
            default:
                break
            }
            delegate?.onOtpTextFieldEditingChanged(otpCode: getOtpCode())
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
        delegate?.onOtpTextFieldEditingChanged(otpCode: getOtpCode())
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        return TextFieldFilter.input(string: string, inputType: .number)
    }
    
    func getOtpCode() -> String {
        let tf1 = textField1.text ?? ""
        let tf2 = textField2.text ?? ""
        let tf3 = textField3.text ?? ""
        let tf4 = textField4.text ?? ""
        
        return tf1 + tf2 + tf3 + tf4
    }
}
