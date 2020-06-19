//
//  Global.swift
//  StarterTemplate
//
//  Created by Dhiya Ulhaq Zulha Alamsyah on 25/09/19.
//  Copyright © 2019 dhiyaulhaqza. All rights reserved.
//

import Foundation

func delayAfter(_ seconds: Double, completion: @escaping () -> Void) {
    DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
        completion()
    }
}
