//
//  DZARefreshControl.swift
//  StarterTemplate
//
//  Created by Dhiya Ulhaq Zulha Alamsyah on 31/10/19.
//  Copyright © 2019 dhiyaulhaqza. All rights reserved.
//

import UIKit

class DZARefreshControl: UIRefreshControl {
    
    weak var swipeRefreshDelegate: RefreshControlDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addTarget(self, action:
            #selector(onSwipeRefresh(_:)),
                       for: .valueChanged)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func onSwipeRefresh(_ sender: UIRefreshControl) {
        swipeRefreshDelegate?.onSwipeRefresh()
    }
    
    func isLoading(_ isLoading: Bool) {
        if isLoading {
            beginRefreshingManually()
        } else {
            self.endRefreshing()
        }
    }
    
    func beginRefreshingManually() {
        if let scrollView = superview as? UIScrollView {
            scrollView.setContentOffset(CGPoint(x: 0, y: scrollView.contentOffset.y - frame.height), animated: true)
        }
        self.beginRefreshing()
    }
}

protocol RefreshControlDelegate: class {
    func onSwipeRefresh()
}
