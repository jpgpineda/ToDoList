//
//  SignInViewController.swift
//  ToDoList
//
//  Created by javier pineda on 24/01/24.
//

import UIKit

class SignInViewController: UIViewController {

    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var iconImageView: UIImageView!
    var name: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: true)
        emailTextField.delegate = self
        passwordTextField.delegate = self
        emailTextField.text = name
    }
    
    @IBAction func presentSignUP(_ sender: UIButton) {
    }
    
    @IBAction func requestSignIn(_ sender: UIButton) {
        guard let viewController = ModuleManager.shared.homeDependency.makeListViewController() else { return }
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.modalPresentationStyle = .fullScreen
        self.navigationController?.present(navigationController, animated: true)
    }
    
    @IBAction func dismissView(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}

extension SignInViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text else { return }
        if textField == emailTextField {
            if text.isEmpty || !text.isEmailValid(){
                emailTextField.backgroundColor = .blue
            }
        } else {
            
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.backgroundColor = .white
    }
}
