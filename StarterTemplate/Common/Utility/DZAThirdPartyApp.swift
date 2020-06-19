//
//  DZAThirdPartyApp.swift
//  StarterTemplate
//
//  Created by Dhiya Ulhaq Zulha Alamsyah on 27/11/19.
//  Copyright © 2019 dhiyaulhaqza. All rights reserved.
//

import Foundation
import UIKit
import MessageUI

class DZAThirdPartyApp {
    
    static func openWhatsApp(phoneNumber: String, message: String = "") {
        let msg = message.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let appURL = URL(string: "https://wa.me/\(phoneNumber)/?text=\(msg)")
        guard let waUrl = appURL else {
            return
        }
        if UIApplication.shared.canOpenURL(waUrl) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(waUrl, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(waUrl)
            }
        }
    }
    
    static func openMail(viewController: UIViewController, delegate: MFMailComposeViewControllerDelegate, email: String, subject: String, body: String) -> Bool {
        let isCanSendMail = MFMailComposeViewController.canSendMail()
        if isCanSendMail {
            let composeVC = MFMailComposeViewController()
            composeVC.mailComposeDelegate = delegate
            composeVC.setToRecipients([email])
            composeVC.setSubject(subject)
            composeVC.setMessageBody(body, isHTML: false)
            viewController.present(composeVC, animated: true, completion: nil)
        } else {
            Snacky.show(title: "Tidak dapat mengirim email")
        }
        
        return isCanSendMail
    }
    
}
