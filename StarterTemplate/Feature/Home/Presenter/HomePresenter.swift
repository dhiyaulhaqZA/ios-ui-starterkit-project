//
//  HomePresenter.swift
//  StarterTemplate
//
//  Created by Dhiya Ulhaq Zulha Alamsyah on 13/06/20.
//  Copyright © 2020 dhiyaulhaqza. All rights reserved.
//

import UIKit

class HomePresenter: HomeViewToPresenterProtocol {
    var view: HomePresenterToViewProtocol?
    var interactor: HomePresenterToInteractorProtocol?
    var router: HomePresenterToRouterProtocol?
    
    func openEditorScreen(navigationController: UINavigationController?, param: EditorParam) {
        router?.openEditorScreen(navigationController: navigationController, param: param)
    }
}

extension HomePresenter: HomeInteractorToPresenterProtocol {
}
