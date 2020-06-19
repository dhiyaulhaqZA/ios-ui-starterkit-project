//
//  DZAAlert.swift
//  StarterTemplate
//
//  Created by Dhiya Ulhaq Zulha Alamsyah on 14/11/19.
//  Copyright © 2019 dhiyaulhaqza. All rights reserved.
//

import UIKit

class DZAAlert {
    
    var alert: UIAlertController
    var viewController: UIViewController
    
    init(viewController: UIViewController, preferredStyle: UIAlertController.Style) {
        self.viewController = viewController
        self.alert = UIAlertController(title: nil, message: nil, preferredStyle: preferredStyle)
    }
    
    func setTitle(title: String) -> DZAAlert {
        alert.title = title
        return self
    }
    
    func setMessage(message: String) -> DZAAlert {
        alert.message = message
        return self
    }
    
    func addAction(title: String, style: UIAlertAction.Style = .default,
                   handler: ((UIAlertAction) -> Void)?) -> DZAAlert {
        alert.addAction(UIAlertAction(title: title, style: style, handler: handler))
        return self
    }
    
    func show() {
        viewController.present(alert, animated: true, completion: nil)
    }
}
