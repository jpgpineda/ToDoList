//
//  StorageContext.swift
//  ToDoList
//
//  Created by javier pineda on 30/01/24.
//

import Foundation
import RealmSwift

protocol StorageContext {
    func saveModels<T>(models: [T]) where T: Object
    func updateModel<T>(model: T) where T: Object
    func getModel(model: Object.Type, predicate: NSPredicate?) -> [Object]?
    func deleteModel<T: Object>(model: T)
    func removeAll()
}

class StorageContextImplementation: StorageContext {
    private var realm: Realm?
    
    init(realm: Realm?) {
        self.realm = realm
    }
    
    func saveModels<T>(models: [T]) where T: Object {
        do {
            try realm?.write {
                realm?.add(models, update: .all)
            }
        } catch {
            print("Hubo un error en realm: \(error.localizedDescription)")
        }
    }
    
    func updateModel<T>(model: T) where T: Object {
        do {
            try realm?.write {
                realm?.add(model, update: .modified)
            }
        } catch {
            print("Hubo un error en realm: \(error.localizedDescription)")
        }
    }
    
    func getModel(model: Object.Type, predicate: NSPredicate?) -> [Object]? {
        guard let realm = realm else { return nil }
        if let predicate = predicate {
            return Array(realm.objects(model).filter(predicate))
        }
        return Array(realm.objects(model))
    }
    
    func deleteModel<T: Object>(model: T) {
        do {
            try realm?.write {
                realm?.delete(model)
            }
        } catch {
            print("Hubo un error en realm: \(error.localizedDescription)")
        }
    }
    
    func removeAll() {
        do {
            try realm?.write {
                realm?.deleteAll()
            }
        } catch {
            print("Hubo un error en realm: \(error.localizedDescription)")
        }
    }
}
