//
//  ToDoListButton.swift
//  ToDoList
//
//  Created by javier pineda on 29/01/24.
//

import UIKit

class ToDoListButton: UIButton {
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    private func setup() {
        self.layer.cornerRadius = 16
        backgroundColor = .black
    }
    
    @IBInspectable var localized: String {
        set {
            
        }
        get {
            return .empty
        }
    }
}
