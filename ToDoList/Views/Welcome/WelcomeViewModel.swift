//
//  WelcomeViewModel.swift
//  ToDoList
//
//  Created by javier pineda on 26/01/24.
//

import Foundation

protocol WelcomeViewModel {
    var router: WelcomeRouter { get set }
    func presentSignUP()
    func presentSignIn(name: String)
}

class WelcomeViewModelImplemenation: WelcomeViewModel {
    var router: WelcomeRouter
    
    init(router: WelcomeRouter) {
        self.router = router
    }
    
    func presentSignUP() {
        router.presentSignUp()
    }
    
    func presentSignIn(name: String) {
        router.presentSignIn(name: name)
    }
}
