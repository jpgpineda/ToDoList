//
//  AddTaskViewController.swift
//  ToDoList
//
//  Created by javier pineda on 28/01/24.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

typealias updateTable = (Bool) -> Void

class AddTaskViewController: UIViewController {
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var dueDatePicker: UIDatePicker!
    var task: TaskItem?
    var viewModel: AddTaskViewModel?
    var closure: updateTable!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = AddTaskViewModelImplemenation(router: AddTaskRouterImplementation(controller: self), view: self, db: Firestore.firestore(), auth: Auth.auth())
        titleTextField.delegate = self
        descriptionTextView.delegate = self
    }
    
    @IBAction func dateSelected(_ sender: UIDatePicker) {
        viewModel?.dueDate = sender.date
    }
    
    @IBAction func addNewTask(_ sender: UIButton) {
        viewModel?.addTask()
    }
}

extension AddTaskViewController: AddTaskView {
    func showFailureAlert(message: String) {
        showErrorAlert(message: message)
    }
    
    func updateTable() {
        closure(true)
    }
}

extension AddTaskViewController: UITextFieldDelegate {
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        viewModel?.title = textField.text ?? .empty
        return true
    }
}

extension AddTaskViewController: UITextViewDelegate {
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        viewModel?.description = textView.text
        return true
    }
}
