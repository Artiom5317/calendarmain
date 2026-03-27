//
//  MainViewModel.swift
//  CalendarMain
//
//  Created by Artiom on 18.01.26.
//

import Foundation


#warning("ПОЧЕМУ ПРИ ПЕРВОМ ЗАПУСКЕ ПРИЛОЖЕНИЯ ВЫВОДИТСЯ КУЧА 'СЮДА ПОПАДАЮ', Ошбика , не удалось загрузить, и Rows count: 0 если я даже не открываю этот экран еще блять.")
//
//protocol MainViewModelProtocol: AnyObject {
//    var dayAndMonthText: String { get }
//    //Получения данных
//
//    func getDailyTasks()
//    
//
//    var onDataUpdated: (() -> Void)? { get set }
//    
//    
//    // Получения кол ячеек и данных
//    var dailyTasksCount: Int { get }
//    func dailyTasksData(from index: Int) -> Task?
//    
//    // Пользователь нажал на кнопку и дергаем taskIscompelte
//    func taskIsComplete(at index: Int)
//    
//    // Проверяем выполненный ли день
//    var isDayComplete: Bool? { get }
//}
//
//
//
//
//class MainViewModel: MainViewModelProtocol {
//    
//    
//    
//    let manager = StorageManager.shared
//
//    var dailyRecord: DayRecord?
//    
//    var onDataUpdated: (() -> Void)?
//    
//
//    func getDailyTasks() {
//        self.dailyRecord = manager.getCurrentDayRecord()
//        onDataUpdated?()
//        print(dailyRecord?.dateOfCompetion)
//    }
//    
//    var dailyTasksCount: Int {
//        guard let dailyTasks = dailyRecord else {
//            print("Сюда попадаю ? ")
//            return 0
//        }
//        return dailyTasks.activePlan.tasks.count
//    }
//    
//    func dailyTasksData(from index: Int) -> Task? {
//        guard let dailyRecord else { return nil }
//        return dailyRecord.activePlan.tasks[index]
//    }
//    
//    // Используем вычисляемое свойство напрямую
//    var dayAndMonthText: String {
//        let now = Date()
//        let formatter = DateFormatter()
//        formatter.locale = Locale(identifier: "ru_RU")
//        
//        // Можно сделать всё одним форматтером
//        // "d MMMM" даст "28 Января"
//        formatter.dateFormat = "d MMMM"
//        
//        return formatter.string(from: now).capitalized
//    }
//    
//    var isDayComplete: Bool? {
//        guard let dailyRecord else { return nil }
//        return dailyRecord.dayIsComplete
//    }
//    
//}
//
//
//
//extension MainViewModel {
//    
//    
//    func isAllTasksComplete() -> Bool {
//        guard let dailyRecord else { return false }
//        let tasks = dailyRecord.activePlan.tasks
//        return tasks.allSatisfy { $0.isCompleted }
//    }
//
//    func taskIsComplete(at index: Int) {
//        
//        guard var nonOptionalDayRecord = dailyRecord else { return }
//        // Тоглим задачу
//        nonOptionalDayRecord.activePlan.tasks[index].isCompleted.toggle()
//        // 3. СРАЗУ обновляем локальное свойство, чтобы UI обновился
//        self.dailyRecord = nonOptionalDayRecord
//        if isAllTasksComplete() {
//            // Все задачи сделаны
//            //1 - Обрабатываем день(сохранение currentDay, History, UpdateUI)
//            handleDayCompletion(record: &nonOptionalDayRecord)
//        } else {
//            manager.saveCurrentDayRecord(nonOptionalDayRecord)
//        }
//    }
//    
//    
//    private func handleDayCompletion(record: inout DayRecord) {
//        record.dayCompelete()
//        self.dailyRecord = record
//        StorageManager.shared.saveCurrentDayRecord(record)
//        manager.saveDayRecordToHistory(record)
//        onDataUpdated?()
//    }
//}
//








protocol MainViewModelProtocol: AnyObject {
    // MARK: - UI

    var dayAndMonthText: String { get }
    var isDayComplete: Bool? { get }

    // MARK: - Data Updates

    var onDataUpdated: (() -> Void)? { get set }

    // MARK: - Fetch

    func getDailyTasks()

    // MARK: - Table Data

    var dailyTasksCount: Int { get }
    func dailyTasksData(from index: Int) -> Task?

    // MARK: - Actions

    func taskIsComplete(at index: Int)
    func exitButtonTapped()
}

final class MainViewModel: MainViewModelProtocol {
    
    var onRouteToExit: (() -> Void)?
    func exitButtonTapped() {
        self.onRouteToExit?()
    }
    

    // MARK: - Dependencies

    let manager = StorageManager.shared

    // MARK: - State

    var dailyRecord: DayRecord?
    var onDataUpdated: (() -> Void)?

    // MARK: - Fetch

    func getDailyTasks() {
        dailyRecord = manager.getCurrentDayRecord()
        onDataUpdated?()
        print(dailyRecord?.dateOfCompetion)
    }

    // MARK: - UI

    var dayAndMonthText: String {
        let now = Date()
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ru_RU")
        formatter.dateFormat = "d MMMM"
        return formatter.string(from: now).capitalized
    }

    var isDayComplete: Bool? {
        guard let dailyRecord else { return nil }
        return dailyRecord.dayIsComplete
    }

    // MARK: - Table Data

    var dailyTasksCount: Int {
        guard let dailyRecord else {
            print("Сюда попадаю ? ")
            return 0
        }
        return dailyRecord.activePlan.tasks.count
    }

    func dailyTasksData(from index: Int) -> Task? {
        guard let dailyRecord else { return nil }

        // минимальная защита от out of range
        guard dailyRecord.activePlan.tasks.indices.contains(index) else { return nil }

        return dailyRecord.activePlan.tasks[index]
    }
}

// MARK: - Helpers / Actions

extension MainViewModel {

    func isAllTasksComplete() -> Bool {
        guard let dailyRecord else { return false }
        let tasks = dailyRecord.activePlan.tasks
        return tasks.allSatisfy { $0.isCompleted }
    }

    func taskIsComplete(at index: Int) {
        guard var nonOptionalDayRecord = dailyRecord else { return }

        // минимальная защита от out of range
        guard nonOptionalDayRecord.activePlan.tasks.indices.contains(index) else { return }

        // Тоглим задачу
        nonOptionalDayRecord.activePlan.tasks[index].isCompleted.toggle()

        // СРАЗУ обновляем локальное свойство, чтобы UI обновился
        dailyRecord = nonOptionalDayRecord

        // ⚠️ логичнее проверять nonOptionalDayRecord, но твой метод оставляю
        if isAllTasksComplete() {
            // Все задачи сделаны
            // 1 - Обрабатываем день(сохранение currentDay, History, UpdateUI)
            handleDayCompletion(record: &nonOptionalDayRecord)
        } else {
            manager.saveCurrentDayRecord(nonOptionalDayRecord)
            // ⚠️ если UI должен обновляться всегда — можно дернуть onDataUpdated?() тут
            // onDataUpdated?()
        }
    }

    private func handleDayCompletion(record: inout DayRecord) {
        record.dayCompelete()
        dailyRecord = record

        StorageManager.shared.saveCurrentDayRecord(record)
        manager.saveDayRecordToHistory(record)

        onDataUpdated?()
    }
}






















































































//    init() {
////        if
//    }
//
//    func getDailyTasks() {
//        self.dailyRecord = manager.getCurrentDayRecord()
//        if self.dailyRecord == nil {
//            print("Ошибка: не удалось загрузить DayRecord!")
//            #warning("Если не написать тут return, то onDataUpdate вызовется? как лучше написать? ")
//        }
//
//        #warning("Нужен ли тут DispatchQueue.main.async для onDataUpdate? Алиса говорит что да(ШЛЮХА)")
//        onDataUpdated?()
//
//
//    }
