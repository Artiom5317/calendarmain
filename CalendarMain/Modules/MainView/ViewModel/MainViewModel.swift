//
//  MainViewModel.swift
//  CalendarMain
//
//  Created by Artiom on 18.01.26.
//

import Foundation


#warning("Как работает computietProperty")

protocol MainViewModelProtocol: AnyObject {
    var dayAndMonthText: String { get }
    
    //Получения данных
    #warning("Стоит ли писать getSet ?")
    func getDailyTasks()
    var onDataUpdated: (() -> Void)? { get set }
    // Получения кол ячеек и данных
    var dailyTasksCount: Int { get }
    func dailyTasksData(from index: Int) -> Task?
}

#warning("Почему не стоило делать отедльную переменную, функцию которая поставит в пееременную данные и потом уже другую функцию которая там выведет данные для UIViewController???")
class MainViewModel: MainViewModelProtocol {
    
    let manager = StorageManager.shared
    
    var dailyTasks: DayRecord? = nil
    var onDataUpdated: (() -> Void)?
    
    
    func getDailyTasks() {
        let dailyTasks = manager.getDayRecord()
        onDataUpdated?()
        print(dailyTasks)
    }
    
    var dailyTasksCount: Int {
        guard let dailyTasks = dailyTasks else {
            return 0
        }
        return dailyTasks.activePlan.tasks.count
    }
    func dailyTasksData(from index: Int) -> Task? {
        guard let dailyTasks else { return nil }
        return dailyTasks.activePlan.tasks[index]
        
    }
    
    // Используем вычисляемое свойство напрямую
    var dayAndMonthText: String {
        let now = Date()
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ru_RU")
        
        // Можно сделать всё одним форматтером
        // "d MMMM" даст "28 Января"
        formatter.dateFormat = "d MMMM"
        
        return formatter.string(from: now).capitalized
    }
}
