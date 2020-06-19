//
//  DZAKeychain.swift
//  StarterTemplate
//
//  Created by Dhiya Ulhaq Zulha Alamsyah on 31/10/19.
//  Copyright © 2019 dhiyaulhaqza. All rights reserved.
//

import Foundation

public enum DZAKeychainKey {
    case token
    
    var keyString: String {
        switch self {
        case .token:
            return "keychain_token"
        }
    }
}

class DZAKeychain {
    
    let keychain = KeychainSwift()

    func setToken(value: String) {
        keychain.set(value, forKey: .token)
    }
    
    func getToken() -> String? {
        return keychain.get(.token)
    }
    
    func clearData() {
        keychain.clear()
    }
}
