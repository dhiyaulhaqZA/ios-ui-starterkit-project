//
//  DZACountDownTimer.swift
//  StarterTemplate
//
//  Created by Dhiya Ulhaq Zulha Alamsyah on 23/11/19.
//  Copyright © 2019 dhiyaulhaqza. All rights reserved.
//

import Foundation
import UIKit

class DZACountDownTimer: UIView {
    
    weak var delegate: DZACountDownTimerCallback?
    
    let labelMinute1: UILabel = {
        let label = buildUI.label(id: "dzaCountDownTimer_labelMinute1", style: .headline, color: .negative, align: .center, text: "0", numberOfLines: 1)
        label.font = UIFont(name: FontStyle.headline.font, size: CGFloat(32))
        label.layer.backgroundColor = UIColor.white.cgColor
        label.layer.cornerRadius = 8
        return label
    }()
    
    let labelMinute2: UILabel = {
        let label = buildUI.label(id: "dzaCountDownTimer_labelMinute2", style: .headline, color: .negative, align: .center, text: "0", numberOfLines: 1)
        label.font = UIFont(name: FontStyle.headline.font, size: CGFloat(32))
        label.layer.backgroundColor = UIColor.white.cgColor
        label.layer.cornerRadius = 8
        return label
    }()
    
    let labelSeparator: UILabel = {
        let label = buildUI.label(id: "dzaCounterDownTimer_labelSeparator", style: .headline, color: .white, align: .center, text: ":", numberOfLines: 1)
        label.font = UIFont(name: FontStyle.headline.font, size: CGFloat(32))
        return label
    }()
    
    let labelSecond1: UILabel = {
        let label = buildUI.label(id: "dzaCountDownTimer_labelSecond1", style: .headline, color: .negative, align: .center, text: "0", numberOfLines: 1)
        label.font = UIFont(name: FontStyle.headline.font, size: CGFloat(32))
        label.layer.backgroundColor = UIColor.white.cgColor
        label.layer.cornerRadius = 8
        return label
    }()
    
    let labelSecond2: UILabel = {
        let label = buildUI.label(id: "dzaCountDownTimer_labelSecond2", style: .headline, color: .negative, align: .center, text: "0", numberOfLines: 1)
        label.font = UIFont(name: FontStyle.headline.font, size: CGFloat(32))
        label.layer.backgroundColor = UIColor.white.cgColor
        label.layer.cornerRadius = 8
        return label
    }()
    
    let stackViewContainer: UIStackView = {
        return buildUI.stackView(id: "dzaCountDownTimer_stackViewContainer")
    }()
    
    init(delegate: DZACountDownTimerCallback) {
        super.init(frame: .zero)
        self.delegate = delegate
        setupContainer()
        setupConstraint()
    }
    
    private func setupContainer() {
        addSubview(stackViewContainer)
        stackViewContainer.addSubview(labelMinute1)
        stackViewContainer.addSubview(labelMinute2)
        stackViewContainer.addSubview(labelSeparator)
        stackViewContainer.addSubview(labelSecond1)
        stackViewContainer.addSubview(labelSecond2)
    }
    
    private func setupConstraint() {
        NSLayoutConstraint.activate([
            stackViewContainer.topAnchor.constraint(equalTo: topAnchor),
            stackViewContainer.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackViewContainer.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackViewContainer.trailingAnchor.constraint(equalTo: trailingAnchor)
            ])
        
        NSLayoutConstraint.activate([
            labelMinute1.widthAnchor.constraint(equalTo: stackViewContainer.widthAnchor, multiplier: 0.20),
            labelMinute2.widthAnchor.constraint(equalTo: stackViewContainer.widthAnchor, multiplier: 0.20),
            labelSecond1.widthAnchor.constraint(equalTo: stackViewContainer.widthAnchor, multiplier: 0.20),
            labelSecond2.widthAnchor.constraint(equalTo: stackViewContainer.widthAnchor, multiplier: 0.20),
            labelSeparator.widthAnchor.constraint(equalToConstant: 16),
            labelSeparator.heightAnchor.constraint(equalTo: stackViewContainer.widthAnchor, multiplier: 0.20),
            labelMinute1.heightAnchor.constraint(equalTo: stackViewContainer.widthAnchor, multiplier: 0.20),
            labelMinute2.heightAnchor.constraint(equalTo: stackViewContainer.widthAnchor, multiplier: 0.20),
            labelSecond1.heightAnchor.constraint(equalTo: stackViewContainer.widthAnchor, multiplier: 0.20),
            labelSecond2.heightAnchor.constraint(equalTo: stackViewContainer.widthAnchor, multiplier: 0.20)
            ])
        
        stackViewContainer.distribution = .equalSpacing
        stackViewContainer.axis = .horizontal
        stackViewContainer.addArrangedSubview(labelMinute1)
        stackViewContainer.addArrangedSubview(labelMinute2)
        stackViewContainer.addArrangedSubview(labelSeparator)
        stackViewContainer.addArrangedSubview(labelSecond1)
        stackViewContainer.addArrangedSubview(labelSecond2)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var milliseconds: Int64 = 0
    var timer: Timer?
    
    func startCountDown(milliseconds: Int64) {
        self.milliseconds = milliseconds
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(onTimeUpdate), userInfo: nil, repeats: true)
    }
    
    func stopCountDown() {
        timer?.invalidate()
    }
    
    private func updateView() {
        let countDown = CountDownTimer.getCountDownString(milliSeconds: milliseconds)
        labelMinute1.text = countDown.0
        labelMinute2.text = countDown.1
        labelSecond1.text = countDown.2
        labelSecond2.text = countDown.3
    }
    
    @objc func onTimeUpdate() {
        milliseconds -= 1000
        let seconds = milliseconds / 1000
        
        if seconds <= 0 {
            timer?.invalidate()
            labelMinute1.text = "0"
            labelMinute2.text = "0"
            labelSecond1.text = "0"
            labelSecond2.text = "0"
            delegate?.onCountDownFinish()
        } else {
            updateView()
            delegate?.onCountDownUpdate(seconds: seconds)
        }
    }
}

protocol DZACountDownTimerCallback: class {
    func onCountDownUpdate(seconds: Int64)
    func onCountDownFinish()
}
