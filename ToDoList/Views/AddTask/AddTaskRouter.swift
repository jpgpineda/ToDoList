//
//  AddTaskRouter.swift
//  ToDoList
//
//  Created by javier pineda on 28/01/24.
//

import Foundation

protocol AddTaskRouter {
    func showLoaderView()
    func dismissLoaderView()
    func dismissView()
}

class AddTaskRouterImplementation: AddTaskRouter {
    private var controller: AddTaskViewController
    
    init(controller: AddTaskViewController) {
        self.controller = controller
    }
    
    func showLoaderView() {
        controller.showLoader()
    }
    
    func dismissLoaderView() {
        controller.dismissLoader()
    }
    
    func dismissView() {
        controller.dismiss(animated: true)
    }
}
