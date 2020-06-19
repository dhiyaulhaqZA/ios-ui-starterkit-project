//
//  EditorPresenterProtocol.swift
//  StarterTemplate
//
//  Created by Dhiya Ulhaq Zulha Alamsyah on 13/06/20.
//  Copyright © 2020 dhiyaulhaqza. All rights reserved.
//

import UIKit

protocol EditorViewToPresenterProtocol: class {
    var view: EditorPresenterToViewProtocol? {get set}
    var interactor: EditorPresenterToInteractorProtocol? {get set}
    var router: EditorPresenterToRouterProtocol? {get set}
}

protocol EditorPresenterToViewProtocol: class {
}

protocol EditorPresenterToRouterProtocol: class {
    static func createModule(param: EditorParam) -> EditorViewController
}

protocol EditorPresenterToInteractorProtocol: class {
    var presenter: EditorInteractorToPresenterProtocol? {get set}
}

protocol EditorInteractorToPresenterProtocol: class {
}
