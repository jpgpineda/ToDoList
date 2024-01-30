//
//  TaskItem.swift
//  ToDoList
//
//  Created by javier pineda on 28/01/24.
//

import Foundation
import FirebaseFirestore

struct TaskItem {
    let id: String
    let title: String
    let description: String
    let dueDate: Date
    let isCompleted: Bool
    
    init(document: QueryDocumentSnapshot) {
        let data = document.data()
        id = data["id"] as? String ?? .empty
        title = data["title"] as? String ?? .empty
        description = data["description"] as? String ?? .empty
        let timeStamp = data["dueDate"] as? Timestamp
        dueDate = timeStamp?.dateValue() ?? Date()
        isCompleted = data["isCompleted"] as? Bool ?? false
    }
    
    init(model: TaskItemModel) {
        id = model.id
        title = model.title
        description = model.taskDescription
        dueDate = model.dueDate
        isCompleted = model.isCompleted
    }
}
