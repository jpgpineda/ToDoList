//
//  SignUpRouter.swift
//  ToDoList
//
//  Created by javier pineda on 26/01/24.
//

import UIKit

protocol SignUpRouter {
    var controller: SignUpViewController { get set }
    func showLoaderView()
    func dismissLoaderView()
    func presentTaskList()
    func dismissView()
}

class SignUpRouterImplementation: SignUpRouter {
    var controller: SignUpViewController
    
    init(controller: SignUpViewController) {
        self.controller = controller
    }
    
    func showLoaderView() {
        controller.showLoader()
    }
    
    func dismissLoaderView() {
        controller.dismissLoader()
    }
    
    func presentTaskList() {
        guard let viewController = ModuleManager.shared.homeDependency.makeListViewController() else { return }
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.modalPresentationStyle = .fullScreen
        controller.navigationController?.present(navigationController, animated: true)
    }
    
    func dismissView() {
        controller.navigationController?.popViewController(animated: true)
    }
}
