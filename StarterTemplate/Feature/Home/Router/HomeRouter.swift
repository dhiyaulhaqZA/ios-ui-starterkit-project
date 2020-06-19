//
//  HomeRouter.swift
//  StarterTemplate
//
//  Created by Dhiya Ulhaq Zulha Alamsyah on 13/06/20.
//  Copyright © 2020 dhiyaulhaqza. All rights reserved.
//

import UIKit

class HomeRouter: HomePresenterToRouterProtocol {

    static func createModule(param: HomeParam) -> HomeViewController {
        let layout = DZACollectionViewFlowLayout()
        let view = HomeViewController(collectionViewLayout: layout)
        let presenter: HomeViewToPresenterProtocol & HomeInteractorToPresenterProtocol = HomePresenter()
        let interactor: HomePresenterToInteractorProtocol = HomeInteractor()
        let router: HomePresenterToRouterProtocol = HomeRouter()
        view.param = param
        view.title = "Home"
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        return view
    }
    
    func openEditorScreen(navigationController: UINavigationController?, param: EditorParam) {
        let targetVC = EditorRouter.createModule(param: param)
        navigationController?.pushViewController(targetVC, animated: true)
    }
}
