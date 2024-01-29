//
//  SignInViewController.swift
//  ToDoList
//
//  Created by javier pineda on 24/01/24.
//

import UIKit
import FirebaseAuth

class SignInViewController: UIViewController {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var iconImageView: UIImageView!
    var viewModel: SignInViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        containerView.roundCorners([.topLeft, .topRight], radius: 16.0)
        viewModel = SignInViewModelImplemenation(router: SignInRouterImplementation(controller: self), view: self, auth: Auth.auth())
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    @IBAction func presentSignUP(_ sender: UIButton) {
    }
    
    @IBAction func requestSignIn(_ sender: UIButton) {
        viewModel?.requestSignIn()
    }
    
    @IBAction func dismissView(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    private func validateFields() {
        guard let viewModel = viewModel else { return }
        signInButton.isEnabled = viewModel.validateData()
        signInButton.backgroundColor = viewModel.validateData() ? .blue : .darkGray
    }
}

extension SignInViewController: SignInView {
    func showFailureAlert(message: String) {
        showErrorAlert(message: message)
    }
}

extension SignInViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text else { return }
        if textField == emailTextField {
            viewModel?.email = text
        } else {
            viewModel?.password = text
        }
        validateFields()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.backgroundColor = .white
    }
}
