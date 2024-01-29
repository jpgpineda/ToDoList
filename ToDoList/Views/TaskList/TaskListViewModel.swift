//
//  TaskListViewModel.swift
//  ToDoList
//
//  Created by javier pineda on 28/01/24.
//

import Foundation

protocol TaskListView {
    func updateContent(tasks: [TaskItem])
}

protocol TaskListViewModel {
    func presentAddTask(task: TaskItem?)
    func signOut()
    func deleteTask()
    func updateTaskStatus(task: TaskItem, isCompleted: Bool)
    func getTasks()
}

class TaskListViewModelImplemenation: TaskListViewModel {
    private var router: TaskListRouter
    
    init(router: TaskListRouter) {
        self.router = router
    }
    
    func presentAddTask(task: TaskItem?) {
        router.presentAddTask(task: task)
    }
    
    func signOut() {
        
    }
    
    func deleteTask() {
        
    }
    
    func updateTaskStatus(task: TaskItem, isCompleted: Bool) {
        
    }
    
    func getTasks() {
        print("Obtener tareas")
    }
}
