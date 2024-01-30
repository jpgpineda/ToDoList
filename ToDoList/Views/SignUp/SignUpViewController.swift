//
//  SignUpViewController.swift
//  ToDoList
//
//  Created by javier pineda on 26/01/24.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var genreControl: UISegmentedControl!
    @IBOutlet weak var confirmTextField: UITextField!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var lastNameTextField: UITextField!
    var viewModel: SignUpViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = SignUpViewModelImplemenation(router: SignUpRouterImplementation(controller: self))
        view.hideKeyboardWhenTappedAround()
        containerView.roundCorners([.topLeft, .topRight], radius: 16.0)
        nameTextField.delegate = self
        lastNameTextField.delegate = self
        userNameTextField.delegate = self
        phoneTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    @IBAction func requestSignUp(_ sender: UIButton) {
        viewModel?.requestSignUp()
    }
    
    @IBAction func dismissView(_ sender: UIButton) {
        viewModel?.dismissView()
    }
}

extension SignUpViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text else { return }
        switch textField {
        case nameTextField:
            viewModel?.name = text
        case lastNameTextField:
            viewModel?.lastName = text
        case userNameTextField:
            viewModel?.userName = text
        case phoneTextField:
            viewModel?.phone = text
        case emailTextField:
            viewModel?.email = text
        case passwordTextField:
            viewModel?.password = text
        default:
            break
        }
    }
}
