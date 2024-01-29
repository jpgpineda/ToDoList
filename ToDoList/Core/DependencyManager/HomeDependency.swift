////
////  HomeDependency.swift
////  ToDoList
////
////  Created by javier pineda on 25/01/24.
////

import Swinject

protocol HomeDependency {
    var container: Container { get set }
    func makeListViewController() -> TaskListViewController?
    func makeAddTaskViewController(task: TaskItem?) -> AddTaskViewController?
}

class HomeDependencyImplementation: HomeDependency {
    var container: Container
    
    init(container: Container) {
        self.container = container
        registerListViewController()
        registerAddTaskViewController()
    }
    
    func registerListViewController() {
        container.register(TaskListViewController.self) { _ in
            return TaskListViewController()
        }
    }
    
    func makeListViewController() -> TaskListViewController? {
        container.resolve(TaskListViewController.self)
    }
    
    private func registerAddTaskViewController() {
        container.register(AddTaskViewController.self) { _ in
            return AddTaskViewController()
        }
    }
    
    func makeAddTaskViewController(task: TaskItem?) -> AddTaskViewController? {
        guard let viewController = container.resolve(AddTaskViewController.self) else { return nil }
        viewController.task = task
        return viewController
    }
}
