//
//  SignInRouter.swift
//  ToDoList
//
//  Created by javier pineda on 28/01/24.
//

import UIKit

protocol SignInRouter {
    func showLoaderView()
    func dismissLoaderView()
    func presentTaskList()
    func dismissView()
}

class SignInRouterImplementation: SignInRouter {
    private var controller: SignInViewController
    
    init(controller: SignInViewController) {
        self.controller = controller
    }
    
    func showLoaderView() {
        
    }
    
    func dismissLoaderView() {
        
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
