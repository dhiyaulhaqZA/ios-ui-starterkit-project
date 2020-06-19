//
//  QRCodeView.swift
//  StarterTemplate
//
//  Created by Dhiya Ulhaq Zulha Alamsyah on 27/11/19.
//  Copyright © 2019 dhiyaulhaqza. All rights reserved.
//

import UIKit

class QRCodeView: UIView {
    lazy var filter = CIFilter(name: "CIQRCodeGenerator")
    lazy var imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imageView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = bounds
    }
    
    func generateCode(_ string: String, foregroundColor: UIColor = .black, backgroundColor: UIColor = .white) {
        guard let filter = filter,
            let data = string.data(using: .isoLatin1, allowLossyConversion: false) else {
                return
        }
        
        filter.setValue(data, forKey: "inputMessage")
        
        guard let ciImage = filter.outputImage else {
            return
        }
        DispatchQueue.main.async {
            let transformed = ciImage.transformed(by: CGAffineTransform.init(scaleX: 10, y: 10))
            let invertFilter = CIFilter(name: "CIColorInvert")
            invertFilter?.setValue(transformed, forKey: kCIInputImageKey)
            
            let alphaFilter = CIFilter(name: "CIMaskToAlpha")
            alphaFilter?.setValue(invertFilter?.outputImage, forKey: kCIInputImageKey)
            
            if let outputImage = alphaFilter?.outputImage {
                self.imageView.tintColor = foregroundColor
                self.imageView.backgroundColor = backgroundColor
                self.imageView.image = UIImage(ciImage: outputImage, scale: 2.0, orientation: .up)
                    .withRenderingMode(.alwaysTemplate)
            }
        }
    }
}
