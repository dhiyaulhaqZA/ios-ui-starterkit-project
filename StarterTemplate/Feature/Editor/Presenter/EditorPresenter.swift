//
//  EditorPresenter.swift
//  StarterTemplate
//
//  Created by Dhiya Ulhaq Zulha Alamsyah on 13/06/20.
//  Copyright © 2020 dhiyaulhaqza. All rights reserved.
//

import Foundation

class EditorPresenter: EditorViewToPresenterProtocol {
    var view: EditorPresenterToViewProtocol?
    var interactor: EditorPresenterToInteractorProtocol?
    var router: EditorPresenterToRouterProtocol?
}

extension EditorPresenter: EditorInteractorToPresenterProtocol {
}
