//
//  CountDownTimer.swift
//  StarterTemplate
//
//  Created by Dhiya Ulhaq Zulha Alamsyah on 11/12/19.
//  Copyright © 2019 dhiyaulhaqza. All rights reserved.
//

import Foundation

class CountDownTimer {
    
    // swiftlint:disable all
    static func getCountDownString(milliSeconds: Int64) -> (String, String, String, String) {
        let seconds = milliSeconds / 1000
        let minutes = seconds / 60
        let minute1 = minutes / 10
        let minute2 = minutes % 10
        let second2 = seconds % 60 % 10
        let second1 = (seconds % 60 - second2) / 10
        
        return (String(minute1), String(minute2), String(second1), String(second2))
    }
    
}
