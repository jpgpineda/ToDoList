//
//  SignInViewModel.swift
//  ToDoList
//
//  Created by javier pineda on 25/01/24.
//

import FirebaseAuth

protocol SignInView {
    func showFailureAlert(message: String)
}

protocol SignInViewModel {
    var email: String { get set }
    var password: String { get set }
    func dismissView()
    func requestSignIn()
    func validateData() -> Bool
}

class SignInViewModelImplemenation: SignInViewModel {
    private var router: SignInRouter
    private var view: SignInView
    private var auth: Auth
    var email: String = .empty
    var password: String = .empty
    
    init(router: SignInRouter,
         view: SignInView,
         auth: Auth) {
        self.router = router
        self.view = view
        self.auth = auth
    }
    
    func dismissView() {
        router.dismissView()
    }
    
    func requestSignIn() {
        router.showLoaderView()
        auth.signIn(withEmail: email, password: password) { [weak self] _, error in
            self?.router.dismissLoaderView()
            if let error = error {
                self?.view.showFailureAlert(message: error.localizedDescription)
            } else {
                self?.router.presentTaskList()
            }
        }
    }
    
    func validateData() -> Bool {
        var isValid = true
        if email.isEmpty || !email.isEmailValid() {
            isValid = false
        }
        if password.isEmpty {
            isValid = false
        }
        return isValid
    }
}
