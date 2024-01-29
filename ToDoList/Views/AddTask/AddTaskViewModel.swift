//
//  AddTaskViewModel.swift
//  ToDoList
//
//  Created by javier pineda on 28/01/24.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

protocol AddTaskView {
    func showFailureAlert(message: String)
    func updateTable()
}

protocol AddTaskViewModel {
    var title: String { get set }
    var description: String { get set }
    var dueDate: Date { get set }
    func addTask()
}

class AddTaskViewModelImplemenation: AddTaskViewModel {
    private var router: AddTaskRouter
    private var view: AddTaskView
    private var db: Firestore
    private var auth: Auth
    var title: String = .empty
    var description: String = .empty
    var dueDate: Date = Date()
    
    init(router: AddTaskRouter, view: AddTaskView, db: Firestore, auth: Auth) {
        self.router = router
        self.view = view
        self.db = db
        self.auth = auth
    }
    
    func addTask() {
        router.showLoaderView()
        guard let userId = auth.currentUser?.uid else { return }
        db.collection("Usuarios").document(userId).collection("Tasks").document().setData(["Title" : title,
                                                                                           "description": description,
                                                                                           "dueDate": Timestamp(date: dueDate)]) { [weak self] error in
            self?.router.dismissLoaderView()
            if let error = error {
                self?.view.showFailureAlert(message: error.localizedDescription)
            } else {
                self?.view.updateTable()
                self?.router.dismissView()
            }
        }
    }
}

