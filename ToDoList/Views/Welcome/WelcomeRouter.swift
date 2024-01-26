//
//  WelcomeRouter.swift
//  ToDoList
//
//  Created by javier pineda on 26/01/24.
//

import UIKit

enum TransitionType {
    case push
    case modal
}

protocol WelcomeRouter {
    var controller: WelcomeViewController { get set }
    func presentSignUp()
    func presentSignIn(name: String)
}

class WelcomeRouterImplementation: WelcomeRouter {
    var controller: WelcomeViewController
    
    init(controller: WelcomeViewController) {
        self.controller = controller
    }
    
    func presentViewController(viewController: UIViewController, type: TransitionType) {
        if type == .modal {
            controller.present(viewController, animated: true)
        } else {
            controller.navigationController?.show(viewController, sender: nil)
        }
    }
    
    func presentSignUp() {
        guard let viewController = ModuleManager.shared.onboardingDependency.makeSignUPViewController() else { return }
        presentViewController(viewController: viewController, type: .push)
    }
    
    func presentSignIn(name: String) {
        guard let viewController = ModuleManager.shared.onboardingDependency.makeSignInViewController(name: name) else { return }
        presentViewController(viewController: viewController, type: .push)
    }
}
