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
    func makeLoaderViewController() -> LoaderViewController?
}

class OnboardingDependencyImplementation: OnboardingDependency {
    var container: Container
    
    init(container: Container) {
        self.container = container
        registerSignInViewController()
        registerSignUpViewController()
        registerLoaderViewController()
    }
    
    private func registerSignInViewController() {
        container.register(SignInViewController.self) { _ in
            return SignInViewController()
        }
    }
    
    func makeSignInViewController(name: String?) -> SignInViewController? {
        guard let viewController = container.resolve(SignInViewController.self) else { return nil }
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
    
    private func registerLoaderViewController() {
        container.register(LoaderViewController.self) { _ in
            return LoaderViewController()
        }
    }
    
    func makeLoaderViewController() -> LoaderViewController? {
        return container.resolve(LoaderViewController.self)
    }
}
