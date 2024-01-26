////
////  OnboardingDependency.swift
////  ToDoList
////
////  Created by javier pineda on 24/01/24.
////

import Swinject

protocol OnboardingDependency {
    var container: Container { get }
    func makeSignInViewController(name: String?) -> SignInViewController?
    func makeSignUPViewController() -> SignUpViewController?
}

class OnboardingDependencyImplementation: OnboardingDependency {
    var container: Container
    
    init(container: Container) {
        self.container = container
        registerSignInViewController()
        registerSignUpViewController()
    }
    
    private func registerSignInViewController() {
        container.register(SignInViewController.self) { _ in
            return SignInViewController()
        }
    }
    
    func makeSignInViewController(name: String?) -> SignInViewController? {
        guard let viewController = container.resolve(SignInViewController.self) else { return nil }
        viewController.name = name
        return viewController
    }
    
    private func registerSignUpViewController() {
        container.register(SignUpViewController.self) { _ in
            return SignUpViewController()
        }
    }
    
    func makeSignUPViewController() -> SignUpViewController? {
        return container.resolve(SignUpViewController.self)
    }
}
