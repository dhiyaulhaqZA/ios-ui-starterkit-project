//
//  EditorRouter.swift
//  StarterTemplate
//
//  Created by Dhiya Ulhaq Zulha Alamsyah on 13/06/20.
//  Copyright © 2020 dhiyaulhaqza. All rights reserved.
//

import UIKit

class EditorRouter: EditorPresenterToRouterProtocol {
    
    static func createModule(param: EditorParam) -> EditorViewController {
        let layout = UICollectionViewFlowLayout()
        let view = EditorViewController(collectionViewLayout: layout)
        let presenter: EditorViewToPresenterProtocol & EditorInteractorToPresenterProtocol = EditorPresenter()
        let interactor: EditorPresenterToInteractorProtocol = EditorInteractor()
        let router: EditorPresenterToRouterProtocol = EditorRouter()
        view.param = param
        view.title = "Editor"
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        return view
    }
}
