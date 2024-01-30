//
//  Tools.swift
//  ToDoList
//
//  Created by javier pineda on 24/01/24.
//

import Foundation

struct Regex {
    static let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
}

class CVDateFormatter {
    static let formatter = DateFormatter()
    static let byDatMonthYearTime = "dd/MMM/yyyy HH:mm"
    
    static func normalDate(_ date: Date) -> String {
        formatter.dateFormat = CVDateFormatter.byDatMonthYearTime
        return formatter.string(from: date)
    }
}
