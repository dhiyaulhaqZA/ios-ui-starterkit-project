//
//  AuthLogout.swift
//  StarterTemplate
//
//  Created by Dhiya Ulhaq Zulha Alamsyah on 28/11/19.
//  Copyright © 2019 dhiyaulhaqza. All rights reserved.
//

import UIKit

class AuthLogout {
    
    static func logout(_ viewController: UIViewController) {
        let keychain = DZAKeychain()
        keychain.clearData()
//        let targetVc = LoginRouter.createModule()
//        targetVc.modalPresentationStyle = .fullScreen
//        viewController.present(targetVc, animated: true, completion: nil)
    }
    
    static func gotoLogin(_ viewController: UIViewController) {
//        let targetVc = LoginRouter.createModule()
//        targetVc.modalPresentationStyle = .fullScreen
//        viewController.present(targetVc, animated: true, completion: nil)
    }
}
