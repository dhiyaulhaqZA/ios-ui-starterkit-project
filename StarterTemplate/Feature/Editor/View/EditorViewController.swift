//
//  EditorViewController.swift
//  StarterTemplate
//
//  Created by Dhiya Ulhaq Zulha Alamsyah on 13/06/20.
//  Copyright © 2020 dhiyaulhaqza. All rights reserved.
//

import UIKit

class EditorViewController: UICollectionViewController {
    
    var presenter: EditorViewToPresenterProtocol?
    var param: EditorParam?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        collectionView.backgroundColor = .green
    }
    
}
