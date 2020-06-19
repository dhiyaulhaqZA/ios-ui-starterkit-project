//
//  Debouncer.swift
//  StarterTemplate
//
//  Created by Dhiya Ulhaq Zulha Alamsyah on 03/01/20.
//  Copyright © 2020 dhiyaulhaqza. All rights reserved.
//

import Foundation

class Debouncer: NSObject {
    var callback: (() -> Void)?
    var delay: Double
    weak var timer: Timer?

    init(delay: Double) {
        self.delay = delay
    }

    func execute(callback: @escaping (() -> Void)) {
        self.callback = callback
        
        timer?.invalidate()
        let nextTimer = Timer.scheduledTimer(timeInterval: delay, target: self, selector: #selector(Debouncer.fireNow), userInfo: nil, repeats: false)
        timer = nextTimer
    }

    @objc func fireNow() {
        callback?()
    }
}
