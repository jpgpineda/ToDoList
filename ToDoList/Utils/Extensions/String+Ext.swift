//
//  String+Ext.swift
//  ToDoList
//
//  Created by javier pineda on 24/01/24.
//

import UIKit

extension String {
    static let empty: String = ""
    
    func isEmailValid() -> Bool {
        let emailTest = NSPredicate(format: "SELF MATCHES %@", Regex.emailRegex)
        return emailTest.evaluate(with: self)
    }
}
