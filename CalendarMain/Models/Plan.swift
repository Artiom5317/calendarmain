//
//  Plan.swift
//  CalendarMain
//
//  Created by Artiom on 18.01.26.
//

import Foundation


struct Plan: Codable, Identifiable {
    let id: UUID
    var title: String
    var tasks: [Task]
    var isActive: Bool
    let dataCreated: Date
    
    init(id: UUID = UUID(), title: String, tasks: [Task], isActive: Bool = false, dataCreate: Date = Date()) {
        self.id = id
        self.title = title
        self.tasks = tasks
        self.isActive = isActive
        self.dataCreated = dataCreate
    }
}


struct Task: Codable, Identifiable {
    let id: UUID
    var toDo: String
    var isCompleted: Bool
    
    init(id: UUID = UUID(), toDo: String, isCompleted: Bool = false) {
        self.id = id
        self.toDo = toDo
        self.isCompleted = isCompleted
    }
    
}


//struct DayRecord: Codable, Identifiable {
//    var id: UUID = UUID()
//    var dayIsComplete: Bool = false
//    var activePlan: Plan
//    var date: Date
//    var dateOfCompetion: Date?
//    
//    
//    init(activePlan: Plan, date: Date = Date()) {
//        self.activePlan = activePlan
//        self.date = Calendar.current.startOfDay(for: date)
//    }
//    
//    
//    mutating func dayCompelete() {
//        self.dayIsComplete = true
//        self.dateOfCompetion = Date()
//    }
//    
//}



struct DayRecord: Codable, Identifiable {
    var id: UUID = UUID()
    var dayIsComplete: Bool = false
    var activePlan: Plan
    var date: Date
    var dateOfCompetion: Date?
    
    init(activePlan: Plan, date: Date = Date()) {
        self.activePlan = activePlan
        self.date = Calendar.current.startOfDay(for: date)
    }
    
    // Новый инициализатор для создания с определённым временем дня
    init(activePlan: Plan, year: Int, month: Int, day: Int, hour: Int = 12, minute: Int = 0) {
        var components = DateComponents()
        components.year = year
        components.month = month
        components.day = day
        components.hour = hour
        components.minute = minute
        
        let calendar = Calendar.current
        let date = calendar.date(from: components) ?? Date()
        
        self.activePlan = activePlan
        self.date = calendar.startOfDay(for: date)
    }
    
    mutating func dayCompelete() {
        self.dayIsComplete = true
        self.dateOfCompetion = Date()
    }
}



extension Calendar {
    func dateAtMidday(from date: Date) -> Date? {
        var components = self.dateComponents([.year, .month, .day], from: date)
        components.hour = 12
        components.minute = 0
        components.second = 0
        return self.date(from: components)
    }
}
