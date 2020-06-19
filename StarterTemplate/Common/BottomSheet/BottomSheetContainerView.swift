//
//  BottomSheetContainerView.swift
//  StarterTemplate
//
//  Created by Dhiya Ulhaq Zulha Alamsyah on 28/11/19.
//  Copyright © 2019 dhiyaulhaqza. All rights reserved.
//

import UIKit

protocol BottomSheetDelegate: AnyObject {
    func bottomSheet(_ bottomSheet: BottomSheet, didScrollTo contentOffset: CGPoint)
}

protocol BottomSheet: AnyObject {
    var bottomSheetDelegate: BottomSheetDelegate? { get set }
}

typealias BottomSheetViewController = UIViewController & BottomSheet

class BottomSheetContainerView: UIView {
    
    private let mainView: UIView
    private let sheetView: UIView
    private let headerView: UIView?
    private let sheetBackground = BottomSheetBackgroundView()
    private var sheetBackgroundTopConstraint: NSLayoutConstraint?
    
    let lineView: UIView = {
        let view = buildUI.container(id: "bottomSheet_line")
        view.backgroundColor = .lightGray
        return view
    }()
    
    let containerDrag: UIView = {
        let view = buildUI.container(id: "bottomSheet_containerDrag")
        view.backgroundColor = .white
        return view
    }()
    
    let imageDrag: UIImageView = {
        return buildUI.imageView(id: "bottomSheet_drag", image: R.image.icDrag())
    }()
    
    init(mainView: UIView, sheetView: UIView, headerView: UIView?) {
        self.mainView = mainView
        self.sheetView = sheetView
        self.headerView = headerView
        
        super.init(frame: .zero)
        
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError() }
    
    var topDistance: CGFloat = 0 {
        didSet {
            sheetBackgroundTopConstraint?.constant = topDistance
        }
    }
    
    private func setupViews() {
        // The main view fills the view completely
        addSubview(mainView)
        mainView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainView.leftAnchor.constraint(equalTo: leftAnchor),
            mainView.rightAnchor.constraint(equalTo: rightAnchor),
            mainView.topAnchor.constraint(equalTo: topAnchor),
            mainView.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
        
        // The sheet background
        addSubview(sheetBackground)
        sheetBackground.translatesAutoresizingMaskIntoConstraints = false
        let topConstraint = sheetBackground.consTop(view: self)
        NSLayoutConstraint.activate([
            topConstraint,
            sheetBackground.heightAnchor.constraint(equalTo: heightAnchor),
            sheetBackground.leftAnchor.constraint(equalTo: leftAnchor),
            sheetBackground.rightAnchor.constraint(equalTo: rightAnchor)
            ])
        sheetBackgroundTopConstraint = topConstraint
        
        addSubview(containerDrag)
        containerDrag.addSubview(imageDrag)
        containerDrag.addSubview(lineView)
        NSLayoutConstraint.activate([
            containerDrag.topAnchor.constraint(equalTo: sheetBackground.topAnchor),
            containerDrag.leadingAnchor.constraint(equalTo: sheetBackground.leadingAnchor),
            containerDrag.trailingAnchor.constraint(equalTo: sheetBackground.trailingAnchor),
            containerDrag.heightAnchor.constraint(equalToConstant: 36)
            ])
        
        if let headerView = headerView {
            containerDrag.addSubview(headerView)
            headerView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                headerView.topAnchor.constraint(equalTo: containerDrag.bottomAnchor),
                headerView.leadingAnchor.constraint(equalTo: sheetBackground.leadingAnchor),
                headerView.trailingAnchor.constraint(equalTo: sheetBackground.trailingAnchor),
                headerView.heightAnchor.constraint(equalToConstant: 52)
                ])
        }
        
        NSLayoutConstraint.activate([
            lineView.topAnchor.constraint(equalTo: containerDrag.topAnchor),
            lineView.heightAnchor.constraint(equalToConstant: 0.5),
            lineView.leadingAnchor.constraint(equalTo: containerDrag.leadingAnchor),
            lineView.trailingAnchor.constraint(equalTo: containerDrag.trailingAnchor)
            ])
        
        NSLayoutConstraint.activate([
            imageDrag.topAnchor.constraint(equalTo: containerDrag.topAnchor),
            imageDrag.centerXAnchor.constraint(equalTo: containerDrag.centerXAnchor),
            imageDrag.heightAnchor.constraint(equalToConstant: 36)
            ])
        
        // The sheet table view goes all the way up to the status bar
        addSubview(sheetView)
        sheetView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            sheetView.leftAnchor.constraint(equalTo: leftAnchor),
            sheetView.rightAnchor.constraint(equalTo: rightAnchor),
            sheetView.consTop(view: self),
            sheetView.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
        
        containerDrag.layer.zPosition = 1
        sheetBackground.backgroundColor = .grayBg
    }
    
    // MARK: - UIView overrides
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if sheetBackground.bounds.contains(sheetBackground.convert(point, from: self)) {
            return sheetView.hitTest(sheetView.convert(point, from: self), with: event)
        }
        return mainView.hitTest(mainView.convert(point, from: self), with: event)
    }
    
}

class BottomSheetContainerViewController: UIViewController {
    
    private let mainViewController: UIViewController
    private let sheetViewController: BottomSheetViewController
    private let headerView: UIView
    
    private lazy var bottomSheetContainerView = BottomSheetContainerView(mainView: mainViewController.view,
                                                                         sheetView: sheetViewController.view,
                                                                         headerView: headerView)
    
    init(mainViewController: UIViewController, sheetViewController: BottomSheetViewController, headerView: UIView) {
        self.mainViewController = mainViewController
        self.sheetViewController = sheetViewController
        self.headerView = headerView
        
        super.init(nibName: nil, bundle: nil)
        addChild(mainViewController)
        addChild(sheetViewController)
        
        sheetViewController.bottomSheetDelegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    override func loadView() {
        view = bottomSheetContainerView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainViewController.didMove(toParent: self)
        sheetViewController.didMove(toParent: self)
    }
    
}

extension BottomSheetContainerViewController: BottomSheetDelegate {
    func bottomSheet(_ bottomSheet: BottomSheet, didScrollTo contentOffset: CGPoint) {
        bottomSheetContainerView.topDistance = max(0, -contentOffset.y)
    }
}
