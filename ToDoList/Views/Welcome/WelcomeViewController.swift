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
    var viewModel: WelcomeViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = WelcomeViewModelImplemenation(router: WelcomeRouterImplementation(controller: self))
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    @IBAction func presentSignUp(_ sender: UIButton) {
        viewModel?.presentSignUP()
    }
    
    @IBAction func presentSignIn(_ sender: UIButton) {
        viewModel?.presentSignIn(name: "javier")
    }
}

