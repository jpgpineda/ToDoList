//
//  TaskListRouter.swift
//  ToDoList
//
//  Created by javier pineda on 28/01/24.
//

import Foundation

protocol TaskListRouter {
    func showLoaderView()
    func dismissLoaderView()
    func presentAddTask(task: TaskItem?)
    func signOut()
}

class TaskListRouterImplementation: TaskListRouter {
    private let controller: TaskListViewController
    
    init(controller: TaskListViewController) {
        self.controller = controller
    }
    
    func showLoaderView() {
        controller.showLoader()
    }
    
    func dismissLoaderView() {
        controller.dismissLoader()
    }
    
    func presentAddTask(task: TaskItem?) {
        guard let viewController = ModuleManager.shared.homeDependency.makeAddTaskViewController(task: task) else { return }
        viewController.closure = { isUpdateNeeded in
            guard isUpdateNeeded else { return }
            self.controller.viewModel?.getTasks()
        }
        controller.navigationController?.present(viewController, animated: true)
    }
    
    func signOut() {
        
    }
}
