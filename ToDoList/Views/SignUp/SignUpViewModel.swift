//
//  SignUpViewModel.swift
//  ToDoList
//
//  Created by javier pineda on 26/01/24.
//

import FirebaseAuth
import FirebaseFirestore

protocol SignUpViewModel {
    var name: String { get set }
    var lastName: String { get set }
    var userName: String { get set }
    var phone: String { get set }
    var email: String { get set }
    var password: String { get set }
    var confirmPassword: String { get set }
    func presentTaskList()
    func dismissView()
    func validateData() -> Bool
    func requestSignUp()
}

class SignUpViewModelImplemenation: SignUpViewModel {
    private var router: SignUpRouter
    var name: String = ""
    var lastName: String = ""
    var userName: String = ""
    var phone: String = ""
    var email: String = ""
    var password: String = ""
    var confirmPassword: String = ""
    let auth = Auth.auth()
    let db = Firestore.firestore()
    
    init(router: SignUpRouter) {
        self.router = router
    }
    
    func presentTaskList() {
        router.presentTaskList()
    }
    
    func dismissView() {
        router.dismissView()
    }
    
    func requestSignUp() {
        router.showLoaderView()
        auth.createUser(withEmail: email, password: password) { [weak self] response, error in
            if let error = error {
                self?.router.dismissLoaderView()
                print("Hubo un error: \(error.localizedDescription)")
            } else {
                guard let response = response else { return }
                self?.doUserLogin(user: response.user)
            }
        }
    }
    
    private func doUserLogin(user: User) {
        auth.signIn(withEmail: user.email ?? .empty, password: password) { [weak self] _, error in
            if let error = error {
                self?.router.dismissLoaderView()
                print("Hubo un error: \(error.localizedDescription)")
            } else {
                self?.saveUserInfo()
            }
        }
    }
    
    private func saveUserInfo() {
        guard let userId = auth.currentUser?.uid else { return }
        db.collection("Usuarios").document(userId).setData(["name" : name,
                                                            "lastName": lastName,
                                                            "userName": userName,
                                                            "phone": phone,
                                                            "email": email]) { [weak self] error in
            if let error = error {
                self?.router.dismissLoaderView()
                print("Hubo un error: \(error.localizedDescription)")
            } else {
                self?.router.dismissLoaderView()
                self?.router.presentTaskList()
            }
        }
    }
    
    func validateData() -> Bool {
        var isValid = true
        if name.isEmpty {
            isValid = false
        }
        if lastName.isEmpty {
            isValid = false
        }
        if userName.isEmpty {
            isValid = false
        }
        if phone.isEmpty {
            isValid = false
        }
        if email.isEmpty {
            isValid = false
        }
        if password.isEmpty || password != confirmPassword {
            isValid = false
        }
        if confirmPassword.isEmpty || confirmPassword != password {
            isValid = false
        }
        return isValid
    }
}
