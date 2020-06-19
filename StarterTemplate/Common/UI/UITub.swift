//
//  UITub.swift
//  StarterTemplate
//
//  Created by Dhiya Ulhaq Zulha Alamsyah on 16/09/19.
//  Copyright © 2019 dhiyaulhaqza. All rights reserved.
//

import UIKit
import WebKit

public var buildUI: UITub {
    struct Singleton {
        static let instance = UITub()
    }
    return Singleton.instance
}

public class UITub {
    
     func label(id: String, style: FontStyle, color: UIColor?,
                align: NSTextAlignment = NSTextAlignment.left, text: String, numberOfLines: Int = 0) -> UILabel {
        let label = UILabel(frame: .zero)
        label.accessibilityIdentifier = "label_\(id)"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = color
        label.font = UIFont(name: style.font, size: CGFloat(style.size))
        label.numberOfLines = numberOfLines
        label.textAlignment = align
        label.lineBreakMode = .byTruncatingTail
        label.text = text
        return label
    }
    
    func labelHint(id: String, style: FontStyle, color: UIColor?,
                   align: NSTextAlignment = NSTextAlignment.left, text: String, hint: String, numberOfLines: Int = 0) -> DZALabelHint {
        let labelHint = DZALabelHint(style: style, color: color,
                                     align: align, text: text, hint: hint, numberOfLines: 1)
        labelHint.accessibilityIdentifier = "labelHint_\(id)"
        labelHint.translatesAutoresizingMaskIntoConstraints = false
        return labelHint
    }
    
    func button(id: String, title: String, style: ButtonStyle) -> DZAButton {
        let button = DZAButton(type: .system)
        let fontStyle = FontStyle.headline
        button.accessibilityIdentifier = "button_\(id)"
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = UIFont(name: fontStyle.font, size: CGFloat(fontStyle.size))
        button.layer.cornerRadius = CGFloat(Dimension.init().cornerRadius)
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        button.setStyle(style: style)
        return button
    }
    
    func buttonText(id: String, title: String, fontStyle: FontStyle, color: UIColor?) -> UIButton {
        let button = UIButton(type: .system)
        button.accessibilityIdentifier = "buttonText_\(id)"
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(title, for: .normal)
        button.setTitleColor(color, for: .normal)
        button.titleLabel?.font = UIFont(name: fontStyle.font, size: CGFloat(fontStyle.size))
        return button
    }
    
    func fab(id: String, icon: UIImage?, bgColor: UIColor?, size: CGFloat = 72) -> UIButton {
        let button = UIButton(frame: .zero)
        button.accessibilityIdentifier = "fab_\(id)"
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.widthAnchor.constraint(equalToConstant: size),
            button.heightAnchor.constraint(equalToConstant: size)
            ])
        button.setImage(icon, for: .normal)
        button.backgroundColor = bgColor
        button.layer.cornerRadius = size/2.0
        button.layer.shadowColor = UIColor.gray.cgColor
        button.layer.shadowOffset = CGSize(width: 0.0, height: 10.0)
        button.layer.shadowRadius = 5
        button.layer.shadowOpacity = 0.25
        return button
    }
    
    func textField(id: String, placeHolder: String? = nil,
                   style: RoseTextFieldStyle) -> DZATextField {
        let textField = DZATextField(style: style)
        textField.accessibilityIdentifier = "textfield_\(id)"
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textField.autocapitalizationType = .sentences
        let style = FontStyle.body
        textField.textField.font = UIFont(name: style.font, size: CGFloat(style.size))
        if let placeHolder = placeHolder {
            textField.textField.changePlaceholderColor(placeHolder: placeHolder,
                                                       color: .disableText)
        }
        return textField
    }
    
    func stackView(id: String) -> UIStackView {
        let stackView = UIStackView(frame: .zero)
        stackView.accessibilityIdentifier = "stackview_\(id)"
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }
    
    func cardView(id: String, cornerRadius: CGFloat = 8.0, shadowRadius: CGFloat = 6.0, shadowOpacity: CGFloat = 0.4) -> UIView {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = cornerRadius
        view.layer.shadowColor = UIColor.gray.cgColor
        view.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        view.layer.shadowRadius = shadowRadius
        view.layer.shadowOpacity = Float(shadowOpacity)
        return view
    }
    
    func container(id: String) -> UIView {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }
    
    func segmentedControl(titles: [String]) -> UISegmentedControl {
        let segmentedControl = UISegmentedControl(items: titles)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        return segmentedControl
    }
    
    func collectionView(id: String, layout: DZACollectionViewFlowLayout) -> UICollectionView {
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.accessibilityIdentifier = "collectionView_\(id)"
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
    
    func pageControl(id: String, currentPageColor: UIColor?, pageColor: UIColor?) -> UIPageControl {
        let pageControl = UIPageControl(frame: .zero)
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.accessibilityIdentifier = "pageControl_\(id)"
        pageControl.currentPage = 0
        pageControl.currentPageIndicatorTintColor = currentPageColor
        pageControl.pageIndicatorTintColor = pageColor
        pageControl.isUserInteractionEnabled = false
        return pageControl
    }
    
    func imageView(id: String, image: UIImage?, contentMode: UIView.ContentMode = .scaleAspectFit) -> UIImageView {
        let imageView = UIImageView(frame: .zero)
        imageView.accessibilityIdentifier = "imageView_\(id)"
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = image
        imageView.contentMode = contentMode
        return imageView
    }
    
    func labelWithIcon(id: String, icon: UIImage?, text: String, size: IconLabelSize, fontStyle: FontStyle = .callout, color: UIColor = .black, position: IconLabelPosition = .left) -> IconLabel {
        let iconLabel = IconLabel(image: icon, text: text, size: size, position: position)
        iconLabel.accessibilityIdentifier = "iconLabel_\(id)"
        iconLabel.translatesAutoresizingMaskIntoConstraints = false
        iconLabel.setLabelStyle(style: fontStyle, color: color, align: .left)
        iconLabel.label.numberOfLines = 0
        return iconLabel
    }
    
    func imageLoader(id: String, contentMode: UIView.ContentMode = UIView.ContentMode.scaleToFill) -> ImageLoader {
        let imageLoader = ImageLoader()
        imageLoader.accessibilityIdentifier = "imageLoader_\(id)"
        imageLoader.translatesAutoresizingMaskIntoConstraints = false
        imageLoader.contentMode = contentMode
        return imageLoader
    }
    
    func webView(id: String) -> WKWebView {
        let webConfiguration = WKWebViewConfiguration()
        let webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.accessibilityIdentifier = "webView_\(id)"
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
    }
    
    func refreshControl(id: String, delegate: RefreshControlDelegate) -> DZARefreshControl {
        let refreshControl = DZARefreshControl(frame: .zero)
        refreshControl.accessibilityIdentifier = "refreshControl_\(id)"
        refreshControl.swipeRefreshDelegate = delegate
        return refreshControl
    }
    
    func spinner(id: String, delegate: UIPickerViewDelegate & UIPickerViewDataSource) -> DZASpinner {
        let spinner = DZASpinner(delegate: delegate)
        spinner.accessibilityIdentifier = "spinner_\(id)"
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }
    
    func countDownTimer(id: String, delegate: DZACountDownTimerCallback) -> DZACountDownTimer {
        let countDownTimer = DZACountDownTimer(delegate: delegate)
        countDownTimer.accessibilityIdentifier = "countDownTimer_\(id)"
        countDownTimer.translatesAutoresizingMaskIntoConstraints = false
        return countDownTimer
    }
    
    func qrCode(id: String) -> QRCodeView {
        let qrCodeView = QRCodeView(frame: .zero)
        qrCodeView.accessibilityIdentifier = "qrCode_\(id)"
        qrCodeView.translatesAutoresizingMaskIntoConstraints = false
        return qrCodeView
    }
    
    func textView(id: String, placeHolder: String = "") -> DZATextView {
        let textView = DZATextView(placeHolder: placeHolder)
        textView.accessibilityIdentifier = "textView_\(id)"
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.autocapitalizationType = .sentences
        let style = FontStyle.body
        textView.font = UIFont(name: style.font, size: CGFloat(style.size))
        textView.textContainerInset = UIEdgeInsets(top: 8, left: 14, bottom: 8, right: 14)
        textView.layer.cornerRadius = 6
        textView.backgroundColor = .grayBg
        return textView
    }
    
    func ratingView(id: String, delegate: RatingViewDelegate?) -> RatingView {
        let view = RatingView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.accessibilityIdentifier = "ratingView_\(id)"
        view.editable = false
        view.delegate = delegate
        view.type = .halfRatings
        return view
    }
    
}
