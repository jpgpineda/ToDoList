//
//  Defaults.swift
//  ToDoList
//
//  Created by javier pineda on 30/01/24.
//

import Foundation

enum UserKeys: String {
    case lastSignedUser
}

struct SharedPreferences {
    static let shared = SharedPreferences()
    let defaults = UserDefaults.standard
    
    internal func saveLastSignedUser(email: String) {
        defaults.set(email, forKey: UserKeys.lastSignedUser.rawValue)
    }
    
    internal func getLastSignedUser() -> String {
        return defaults.string(forKey: UserKeys.lastSignedUser.rawValue) ?? .empty
    }
}
