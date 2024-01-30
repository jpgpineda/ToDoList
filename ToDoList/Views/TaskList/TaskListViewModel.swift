//
//  TaskListViewModel.swift
//  ToDoList
//
//  Created by javier pineda on 28/01/24.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

protocol TaskListView {
    func showFailureAlert(message: String)
    func showMessageAlert(message: String)
    func updateContent(tasks: [TaskItem])
}

protocol TaskListViewModel {
    func presentAddTask(task: TaskItem?)
    func signOut()
    func deleteTask(task: TaskItem)
    func updateTaskStatus(task: TaskItem, isCompleted: Bool)
    func presentDeleteConfirmation(task: TaskItem)
    func getTasks(_ isUpdate: Bool)
}

class TaskListViewModelImplemenation: TaskListViewModel {
    private var router: TaskListRouter
    private var view: TaskListView
    private var db: Firestore
    private var auth: Auth
    private let storageContext: StorageContext
    
    init(router: TaskListRouter,
         view: TaskListView,
         db: Firestore,
         auth: Auth,
         storageContext: StorageContext) {
        self.router = router
        self.view = view
        self.db = db
        self.auth = auth
        self.storageContext = storageContext
    }
    
    func presentAddTask(task: TaskItem?) {
        router.presentAddTask(task: task)
    }
    
    func signOut() {
        router.signOut()
    }
    
    func presentDeleteConfirmation(task: TaskItem) {
        router.deleteTask(task: task)
    }
    
    func deleteTask(task: TaskItem) {
        guard let userId = auth.currentUser?.uid else { return }
        router.showLoaderView()
        db.collection("Usuarios").document(userId).collection("Tasks").document(task.id).delete { [weak self] error in
            self?.router.dismissLoaderView()
            if let error = error {
                self?.view.showFailureAlert(message: error.localizedDescription)
            } else {
                self?.view.showMessageAlert(message: "Se elimino correctamente tu tarea")
                self?.getTasks(true)
            }
        }
    }
    
    func updateTaskStatus(task: TaskItem, isCompleted: Bool) {
        guard let userId = auth.currentUser?.uid else { return }
        router.showLoaderView()
        db.collection("Usuarios").document(userId).collection("Tasks").document(task.id).updateData(["isCompleted" : isCompleted]) { [weak self] error in
            self?.router.dismissLoaderView()
            if let error = error {
                self?.view.showFailureAlert(message: error.localizedDescription)
            } else {
                self?.getTasks(true)
            }
        }
    }
    
    func getTasks(_ isUpdate: Bool) {
        guard let tasks = getLocalTasks(),
              !tasks.isEmpty,
              !isUpdate else {
            guard let userId = auth.currentUser?.uid else { return }
            router.showLoaderView()
            db.collection("Usuarios").document(userId).collection("Tasks").getDocuments { [weak self] result, error in
                self?.router.dismissLoaderView()
                if let error = error {
                    self?.view.showFailureAlert(message: error.localizedDescription)
                } else {
                    guard let result = result else { return }
                    let tasks = result.documents.compactMap { TaskItem(document: $0) }
                    self?.storageContext.saveModels(models: result.documents.compactMap({
                        TaskItemModel(with: $0)
                    }))
                    self?.view.updateContent(tasks: tasks)
                }
            }
            return
        }
        view.updateContent(tasks: tasks)
    }
    
    private func getLocalTasks() -> [TaskItem]? {
        guard let taskModels = storageContext.getModel(model: TaskItemModel.self, predicate: nil) as? [TaskItemModel] else { return nil }
        return taskModels.compactMap { TaskItem(model: $0) }
    }
}
