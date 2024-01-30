//
//  TaskItemModel.swift
//  ToDoList
//
//  Created by javier pineda on 30/01/24.
//

import Foundation
import RealmSwift
import FirebaseFirestore

class TaskItemModel: Object {
    @Persisted(primaryKey: true) var id: String = .empty
    @Persisted var title: String = .empty
    @Persisted var taskDescription: String = .empty
    @Persisted var dueDate: Date = Date()
    @Persisted var isCompleted: Bool = false
    
    convenience init(with document: QueryDocumentSnapshot) {
        self.init()
        let data = document.data()
        id = data["id"] as? String ?? .empty
        title = data["title"] as? String ?? .empty
        taskDescription = data["description"] as? String ?? .empty
        let timeStamp = data["dueDate"] as? Timestamp
        dueDate = timeStamp?.dateValue() ?? Date()
        isCompleted = data["isCompleted"] as? Bool ?? false
    }
}
