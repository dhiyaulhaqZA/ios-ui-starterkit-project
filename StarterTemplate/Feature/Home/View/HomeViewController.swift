//
//  HomeViewController.swift
//  StarterTemplate
//
//  Created by Dhiya Ulhaq Zulha Alamsyah on 13/06/20.
//  Copyright © 2020 dhiyaulhaqza. All rights reserved.
//

import UIKit

class HomeViewController: UICollectionViewController {
    
    var presenter: HomeViewToPresenterProtocol?
    var param: HomeParam?
    
    let itemCellIdentifier = "homeItemCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupComponent()
    }
    
    private func setupComponent() {
        view.backgroundColor = .white
        collectionView.backgroundColor = .white
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(onAddButtonTapped))
        
        collectionView.alwaysBounceVertical = true
        collectionView.contentInset = UIEdgeInsets(top: 4, left: 0, bottom: 4, right: 0)
        if let flowLayout = collectionView.collectionViewLayout as? DZACollectionViewFlowLayout {
            let width = UIScreen.main.bounds.size.width
            flowLayout.estimatedItemSize = CGSize(width: width, height: 10)
        }
        
        collectionView.register(HomeItemCell.self, forCellWithReuseIdentifier: itemCellIdentifier)
    }
    
    @objc func onAddButtonTapped() {
        presenter?.openEditorScreen(navigationController: navigationController, param: EditorParam())
    }
    
}
