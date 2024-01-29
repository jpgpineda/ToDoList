//
//  LoaderViewController.swift
//  ToDoList
//
//  Created by javier pineda on 29/01/24.
//

import UIKit

class LoaderViewController: UIViewController {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.startAnimating()
    }
}
