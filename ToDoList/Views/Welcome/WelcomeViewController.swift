//
//  ViewController.swift
//  ToDoList
//
//  Created by javier pineda on 23/01/24.
//

import UIKit

class WelcomeViewController: UIViewController {

    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var signInButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        signUpButton.backgroundColor = .lightGray
    }
    
    @IBAction func presentSignUp(_ sender: UIButton) {
        print("Presentar Sign up")
    }
    
    @IBAction func presentSignIn(_ sender: UIButton) {
        guard let viewController = ModuleManager.shared.onboardingDependency.makeSignInViewController(name: "Javier") else { return }
        navigationController?.show(viewController, sender: nil)
    }
}

