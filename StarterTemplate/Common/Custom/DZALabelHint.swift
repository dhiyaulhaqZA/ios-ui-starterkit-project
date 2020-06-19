//
//  DZALabelHint.swift
//  StarterTemplate
//
//  Created by Dhiya Ulhaq Zulha Alamsyah on 08/01/20.
//  Copyright © 2020 dhiyaulhaqza. All rights reserved.
//

import UIKit

class DZALabelHint: UIView {
    
    private var message = ""
    weak var delegate: LabelHintCallback?
    
    let label: UILabel = {
        return buildUI.label(id: "labelHint", style: .caption1, color: .gray, text: "")
    }()
    
    let hint: UIButton = {
        let button = buildUI.buttonText(id: "labelHint_hint", title: "?", fontStyle: .captionBold, color: .white)
        button.layer.cornerRadius = 9
        button.backgroundColor = UIColor.gray.withAlphaComponent(50)
        return button
    }()
    
    init(style: FontStyle, color: UIColor?, align: NSTextAlignment = NSTextAlignment.left,
         text: String, hint: String, numberOfLines: Int = 0) {
        super.init(frame: .zero)
        self.message = hint
        label.textColor = color
        label.font = UIFont(name: style.font, size: CGFloat(style.size))
        label.numberOfLines = numberOfLines
        label.textAlignment = align
        label.lineBreakMode = .byTruncatingTail
        label.text = text
        setupComponent()
        setupConstraint()
    }
    
    private func setupComponent() {
        addSubview(label)
        addSubview(hint)
        
        hint.addTarget(self, action: #selector(showHint(button:)), for: .touchUpInside)
    }
    
    @objc func showHint(button: UIButton) {
        delegate?.onShowHintClick(message: message)
    }
    
    private func setupConstraint() {
        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: hint.centerYAnchor),
            label.leadingAnchor.constraint(equalTo: leadingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            hint.leadingAnchor.constraint(equalTo: label.trailingAnchor, constant: 8),
            hint.heightAnchor.constraint(equalToConstant: 18),
            hint.widthAnchor.constraint(equalToConstant: 18)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

protocol LabelHintCallback: class {
    func onShowHintClick(message: String)
}

enum LabelHintMessage {
    case name, phone, email, vehicleBrand, vehicleNumber
    
    var message: String {
        switch self {
        case .name:
            return "Indonesia \nNama lengkap diperlukan untuk memudahkan kami mengidentifikasi Anda. \n\nEnglish \nWe use username for identification purpose."
        case .phone:
            return "Indonesia \nNomor handphone akan digunakan untuk berkomunikasi dengan spesialis dan juga sebagai alternatif untuk masuk ke akun. \n\nEnglish \nPhone number will be used for communication purpose and also alternative access for logging in."
        case .email:
            return "Indonesia \nAlamat email digunakan untuk berkomunikasi dan memverifikasi apabila terjadi sesuatu dengan akun Anda. \n\nEnglish \nWe use email for communication and also verification if something goes wrong with the account."
        case .vehicleBrand:
            return "Indonesia \nMerk kendaraan Anda diperlukan untuk memudahkan pelayanan spesialis dalam menangani pesanan layanan. \n\nEnglish \nVehicle brand name is needed to make our specialist easy to identify the vehicle you have."
        case .vehicleNumber:
            return "Indonesia \nPlat nomor kendaraan Anda diperlukan untuk memverifikasi kendaraan Anda dan memudahkan spesialis untuk mengidentifikasi kendaraan Anda dengan cepat. \n\nEnglish \nPlate Number is needed to verify your Vehicle and to make easy for our specialist to identify your vehicle more quick."
        }
    }
}
