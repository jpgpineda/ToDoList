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
}

class HomeDependencyImplementation: HomeDependency {
    var container: Container
    
    init(container: Container) {
        self.container = container
        registerListViewController()
    }
    
    func registerListViewController() {
        container.register(TaskListViewController.self) { _ in
            return TaskListViewController()
        }
    }
    
    func makeListViewController() -> TaskListViewController? {
        container.resolve(TaskListViewController.self)
    }
}
