//
//  ContainerModalViewController.swift
//  StarterTemplate
//
//  Created by Dhiya Ulhaq Zulha Alamsyah on 11/11/19.
//  Copyright © 2019 dhiyaulhaqza. All rights reserved.
//

import UIKit

class ContainerModalViewController: UIViewController, UIScrollViewDelegate {
    
    let imageDrag: UIImageView = {
        return buildUI.imageView(id: "containerModal_drag", image: R.image.icDrag())
    }()
    
    let containerCancel: UIView = {
        let view = buildUI.container(id: "containerModal")
        view.backgroundColor = .white
        return view
    }()
    
    let scrollView: UIScrollView = {
        let view = UIScrollView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    var childView: UIView?
    
    convenience init(childVc: UIViewController) {
        self.init()
        childView = childVc.view
        addChild(childVc)
        childVc.didMove(toParent: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupComponent()
        setupConstraint()
    }
    
    private func setupComponent() {
        scrollView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        scrollView.delegate = self
        containerCancel.addSubview(imageDrag)
        view.addSubview(containerCancel)
        view.addSubview(scrollView)
        if let childView = childView {
            scrollView.addSubview(childView)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        containerCancel.roundCorners(corners: [.topLeft, .topRight], radius: 16.0)
    }
    
    private func setupConstraint() {
        NSLayoutConstraint.activate([
            imageDrag.topAnchor.constraint(equalTo: containerCancel.topAnchor),
            imageDrag.centerXAnchor.constraint(equalTo: containerCancel.centerXAnchor),
            imageDrag.heightAnchor.constraint(equalToConstant: 36)
            ])
        
        NSLayoutConstraint.activate([
            containerCancel.consTop(view: view),
            containerCancel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerCancel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containerCancel.heightAnchor.constraint(equalToConstant: 36)
            ])
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: containerCancel.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
        
        guard let childView = childView else { return }
        NSLayoutConstraint.activate([
            childView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            childView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            childView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            childView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
            ])
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.x != 0 {
            scrollView.contentOffset.x = 0
        }
    }
}
