//
//  StorageManager.swift
//  CalendarMain
//
//  Created by Artiom on 20.01.26.
//

import Foundation



protocol StorageManagerProtocol: AnyObject {
    func loadPlans() -> [Plan]
    func addNewPlan(plan: inout Plan)
}

// Sigleton
//final class StorageManager: StorageManagerProtocol {
//    static let shared = StorageManager()
//
//    init() {}
//    
//    let calendar = Calendar.current
//    
//    
//    // MARK: - Plan Management
//    // Для отображения на экране Plan.
//    
//    //1
//    func loadPlans() -> [Plan] {
//        if let data = UserDefaults.standard.data(forKey: StorageCases.allPlans.rawValue) {
//            let decoder = JSONDecoder()
//            if let data = try? decoder.decode([Plan].self, from: data) {
//                return data
//            }
//        }
//        return []
//    }
//    //2 (save, update)
//    #warning("Вот тут буде будильник на 23:00")
//    func editPlans(plans: [Plan]) {
//        guard let data = try? JSONEncoder().encode(plans) else { return }
//        UserDefaults.standard.set(data, forKey: StorageCases.allPlans.rawValue)
//        
//    }
//    
//    
//    //3
//    // Сохранение нового плана и активация DayRecord Если он первый
//    func addNewPlan(plan: inout Plan) {
//        var currentPlans = loadPlans()
//        
//        if currentPlans.isEmpty {
//            plan.isActive.toggle()
//            saveDayRecord(plan: plan)
//            saveWhichIsActivePlan(plan)
//        }
//        
//        currentPlans.append(plan)
//        let encoder = JSONEncoder()
//        if let data = try? encoder.encode(currentPlans) {
//            UserDefaults.standard.set(data, forKey: StorageCases.allPlans.rawValue)
//        }
//    }
//    
//    // MARK: - Функции для знаниня какой план(какие задачи) у нас активные
//    func saveWhichIsActivePlan(_ plan: Plan) {
//
//        guard let data = try? JSONEncoder().encode(plan) else { return }
//        UserDefaults.standard.set(data, forKey: StorageCases.activePlan.rawValue)
//    }
//    func getWhichActivePlanIs() -> Plan? {
////        guard let planData = UserDefaults.
//        guard let data = UserDefaults.standard.data(forKey: StorageCases.activePlan.rawValue),
//              let plan = try? JSONDecoder().decode(Plan.self, from: data) else { return nil }
//        
//        return plan
//    }
//
//    // Получение дня
//    // MARK: - DayRecord Management
//    //Получение текущего дня DayRecord
//    func getCurrentDayRecord() -> DayRecord? {
//        guard let data = UserDefaults.standard.data(forKey: StorageCases.currentDayRecord.rawValue) else { return nil }
//        guard let dayRecord = try? JSONDecoder().decode(DayRecord.self, from: data) else { return nil }
//        
//        // MARK: - Пока не понял нахуя это нужно
//        let currentDay = calendar.startOfDay(for: Date())
//        let savedDay = calendar.startOfDay(for: dayRecord.date)
//        
////        if currentDay != savedDay {
////            // Дописать
////        }
//        
//        return dayRecord
//        
//    }
////    Сохранение Дня
//    // Создание первогоDayRecord и запись его
//    func saveDayRecord(plan: Plan) {
//        let dayRecord = DayRecord(activePlan: plan)
//        guard let dayRecordData = try? JSONEncoder().encode(dayRecord) else { return }
//        UserDefaults.standard.set(dayRecordData, forKey: StorageCases.currentDayRecord.rawValue)
//        print("Когда я нажал на кнопку другого плана, то я поменял dayRecord (current)")
//    }
//    
//    //Обновить данные в дне (save, update)
//    // Обновить данные в DayRecord (Current)
//    func saveCurrentDayRecord(_ dayRecord: DayRecord) {
//        guard let data = try? JSONEncoder().encode(dayRecord) else { return }
//        
//        UserDefaults.standard.set(data, forKey: StorageCases.currentDayRecord.rawValue)
//    }
//    
//    
//    func completeCurrentDay(with dayRecord: DayRecord) {
//        var updatedRecord = dayRecord
//        updatedRecord.dayCompelete()
//        saveDayRecordToHistory(updatedRecord)
//    }
//    
//    
//}
//
//enum StorageCases: String {
//    case allPlans = "Plan"
//    case currentDayRecord = "currentDayRecord"
//    case dayRecordsHistory = "DayRecordsHistory"
//    
//    //new
//    case activePlan = "activePlan"
//}
//
//
//
////final class
//
//extension StorageManager {
//    
//    // MARK: - History Management
//    func getDayRecordsHistory() -> [DayRecord] {
//        guard let data = UserDefaults.standard.data(forKey: StorageCases.dayRecordsHistory.rawValue),
//              let history = try? JSONDecoder().decode([DayRecord].self, from: data) else {
//            return []
//        }
//        return history
//    }
//    
//    func saveDayRecordToHistory(_ dayRecord: DayRecord) {
//        var history = getDayRecordsHistory()
//        history.append(dayRecord)
//        
//        guard let data = try? JSONEncoder().encode(history) else { return }
//        UserDefaults.standard.set(data, forKey: StorageCases.dayRecordsHistory.rawValue)
//        print("Сохранили в ИСТОРИЮ 1 раз")
//    }
//}
//
//
//
//
//
//extension StorageManager {
//    
//    // MARK: - Day Validation and Update
//    
//    /// Проверяет и обновляет DayRecord при запуске приложения
//    func checkAndUpdateDayRecords() {
//        // 1. Получаем текущий день (начало дня)
//        let currentDate = calendar.startOfDay(for: Date())
//        
//        // 2. Получаем последний сохранённый DayRecord
//        guard let lastDayRecord = getCurrentDayRecord() else {
//            // Нет DayRecord - первый запуск приложения
//            print("Нет сохранённого DayRecord - первый запуск приложения")
//            return
//        }
//        
//        // 3. Получаем дату последнего сохранённого DayRecord (начало дня)
//        let lastDate = calendar.startOfDay(for: lastDayRecord.date)
//        
//        // 4. Проверяем, совпадают ли дни
//        if currentDate == lastDate {
//            print("Текущий день совпадает с сохранённым - ничего не делаем")
//            return
//        }
//        
//        print("Обнаружен новый день или пропущенные дни")
//        
//        // 5. Обрабатываем пропущенные дни
//        processMissedDays(from: lastDate, to: currentDate, lastDayRecord: lastDayRecord)
//    }
//    
//    /// Обрабатывает пропущенные дни между двумя датами
//    private func processMissedDays(from startDate: Date, to endDate: Date, lastDayRecord: DayRecord) {
//        // 1. Проверяем, был ли завершён последний день
//        if !lastDayRecord.dayIsComplete {
//            // Сохраняем не завершённый день в историю
//            saveDayRecordToHistory(lastDayRecord)
//            print("Сохранили не завершённый день в историю: \(lastDayRecord.date)")
//        }
//        
//        // 2. Получаем активный план (текущий)
//        guard let activePlan = getWhichActivePlanIs() else {
//            print("Нет активного плана - не могу создать DayRecord для пропущенных дней")
//            // В этом случае просто создаём новый DayRecord на сегодня без плана?
//            // Или выходим? Нужно уточнить логику
//            return
//        }
//        
//        // 3. Вычисляем все дни между startDate и endDate (исключая сами эти даты)
//        var missedDates: [Date] = []
//        var currentDate = calendar.date(byAdding: .day, value: 1, to: startDate)!
//        
//        while currentDate < endDate {
//            missedDates.append(currentDate)
//            currentDate = calendar.date(byAdding: .day, value: 1, to: currentDate)!
//        }
//        
//        print("Пропущено дней: \(missedDates.count)")
//        
//        // 4. Создаём DayRecord для каждого пропущенного дня
//        for missedDate in missedDates {
//            // Создаём Date с серединой дня (12:00)
//            var components = calendar.dateComponents([.year, .month, .day], from: missedDate)
//            components.hour = 12
//            components.minute = 0
//            components.second = 0
//            
//            guard let dateWithMidday = calendar.date(from: components) else { continue }
//            
//            // Создаём DayRecord с активным планом
//            let missedDayRecord = DayRecord(
//                activePlan: activePlan,
//                date: dateWithMidday
//            )
//            
//            // Сохраняем в историю
//            saveDayRecordToHistory(missedDayRecord)
//            print("Создали DayRecord для пропущенного дня: \(missedDate)")
//        }
//        
//        // 5. Создаём новый DayRecord на сегодня
//        createNewDayRecordForToday()
//    }
//    
//    /// Создаёт новый DayRecord на сегодня с текущим активным планом
//    private func createNewDayRecordForToday() {
//        guard let activePlan = getWhichActivePlanIs() else {
//            print("Не могу создать DayRecord на сегодня - нет активного плана")
//            return
//        }
//        
//        // Создаём новый DayRecord
//        let newDayRecord = DayRecord(activePlan: activePlan)
//        
//        // Сохраняем как текущий DayRecord
//        saveCurrentDayRecord(newDayRecord)
//        print("Создан новый DayRecord на сегодня: \(newDayRecord.date)")
//    }
//}



final class StorageManager: StorageManagerProtocol {
    static let shared = StorageManager()
    
    private init() {}
    
    private let calendar = Calendar.current
    
    // MARK: - Plan Management (Для отображения на экране Plan)
    
    // 1. Загрузка всех планов
    func loadPlans() -> [Plan] {
        guard let data = UserDefaults.standard.data(forKey: StorageCases.allPlans.rawValue) else {
            return []
        }
        
        let decoder = JSONDecoder()
        return (try? decoder.decode([Plan].self, from: data)) ?? []
    }
    
    // 2. Сохранение/обновление всех планов
    
    func editPlans(plans: [Plan]) {
        guard let data = try? JSONEncoder().encode(plans) else { return }
        UserDefaults.standard.set(data, forKey: StorageCases.allPlans.rawValue)
    }
    
    // 3. Добавление нового плана (с активацией первого плана)
    func addNewPlan(plan: inout Plan) {
        var currentPlans = loadPlans()
        
        // Если это первый план, активируем его
        if currentPlans.isEmpty {
            plan.isActive.toggle()
            saveDayRecord(plan: plan)
            saveWhichIsActivePlan(plan)
        }
        
        currentPlans.append(plan)
        
        guard let data = try? JSONEncoder().encode(currentPlans) else { return }
        UserDefaults.standard.set(data, forKey: StorageCases.allPlans.rawValue)
    }
    
    // MARK: - Активный план
    
    func saveWhichIsActivePlan(_ plan: Plan) {
        guard let data = try? JSONEncoder().encode(plan) else { return }
        UserDefaults.standard.set(data, forKey: StorageCases.activePlan.rawValue)
    }
    
    func getWhichActivePlanIs() -> Plan? {
        guard let data = UserDefaults.standard.data(forKey: StorageCases.activePlan.rawValue) else {
            return nil
        }
        return try? JSONDecoder().decode(Plan.self, from: data)
    }
    
    // MARK: - DayRecord Management
    
    // Получение текущего DayRecord
    func getCurrentDayRecord() -> DayRecord? {
        guard let data = UserDefaults.standard.data(forKey: StorageCases.currentDayRecord.rawValue) else {
            return nil
        }
        
        guard let dayRecord = try? JSONDecoder().decode(DayRecord.self, from: data) else {
            return nil
        }
        
        let currentDay = calendar.startOfDay(for: Date())
        let savedDay = calendar.startOfDay(for: dayRecord.date)
        
        // MARK: - TODO: Определить необходимость этой проверки
        // if currentDay != savedDay {
        //     // Требуется дополнительная логика
        // }
        
        return dayRecord
    }
    
    // Создание и сохранение первого DayRecord
    func saveDayRecord(plan: Plan) {
        let dayRecord = DayRecord(activePlan: plan)
        guard let dayRecordData = try? JSONEncoder().encode(dayRecord) else { return }
        
        UserDefaults.standard.set(dayRecordData, forKey: StorageCases.currentDayRecord.rawValue)
        print("При переключении плана обновлён current DayRecord")
    }
    
    // Обновление текущего DayRecord
    func saveCurrentDayRecord(_ dayRecord: DayRecord) {
        guard let data = try? JSONEncoder().encode(dayRecord) else { return }
        UserDefaults.standard.set(data, forKey: StorageCases.currentDayRecord.rawValue)
    }
    
    // Завершение текущего дня
    func completeCurrentDay(with dayRecord: DayRecord) {
        var updatedRecord = dayRecord
        updatedRecord.dayCompelete()
        saveDayRecordToHistory(updatedRecord)
    }
}

// MARK: - History Management Extension
extension StorageManager {
    func getDayRecordsHistory() -> [DayRecord] {
        guard let data = UserDefaults.standard.data(forKey: StorageCases.dayRecordsHistory.rawValue),
              let history = try? JSONDecoder().decode([DayRecord].self, from: data) else {
            return []
        }
        return history
    }
    
    func saveDayRecordToHistory(_ dayRecord: DayRecord) {
        var history = getDayRecordsHistory()
        history.append(dayRecord)
        
        guard let data = try? JSONEncoder().encode(history) else { return }
        UserDefaults.standard.set(data, forKey: StorageCases.dayRecordsHistory.rawValue)
        print("DayRecord сохранён в историю")
    }
}

// MARK: - Day Validation and Update Extension
extension StorageManager {
    /// Проверяет и обновляет DayRecord при запуске приложения
    func checkAndUpdateDayRecords() {
        let currentDate = calendar.startOfDay(for: Date())
        
        guard let lastDayRecord = getCurrentDayRecord() else {
            print("Нет сохранённого DayRecord - первый запуск приложения")
            return
        }
        
        let lastDate = calendar.startOfDay(for: lastDayRecord.date)
        
        guard currentDate != lastDate else {
            print("Текущий день совпадает с сохранённым - обновление не требуется")
            return
        }
        
        print("Обнаружен новый день или пропущенные дни")
        processMissedDays(from: lastDate, to: currentDate, lastDayRecord: lastDayRecord)
    }
    
    /// Обрабатывает пропущенные дни между двумя датами
    private func processMissedDays(from startDate: Date, to endDate: Date, lastDayRecord: DayRecord) {
        // Сохраняем незавершённый день в историю
        if !lastDayRecord.dayIsComplete {
            saveDayRecordToHistory(lastDayRecord)
            print("Незавершённый день сохранён в историю: \(lastDayRecord.date)")
        }
        
        guard let activePlan = getWhichActivePlanIs() else {
            print("Невозможно создать DayRecord - нет активного плана")
            return
        }
        
        // Создаём DayRecord для каждого пропущенного дня
        var missedDates: [Date] = []
        var currentDate = calendar.date(byAdding: .day, value: 1, to: startDate)!
        
        while currentDate < endDate {
            missedDates.append(currentDate)
            currentDate = calendar.date(byAdding: .day, value: 1, to: currentDate)!
        }
        
        print("Количество пропущенных дней: \(missedDates.count)")
        
        for missedDate in missedDates {
            var components = calendar.dateComponents([.year, .month, .day], from: missedDate)
            components.hour = 12
            components.minute = 0
            components.second = 0
            
            guard let dateWithMidday = calendar.date(from: components) else { continue }
            
            let missedDayRecord = DayRecord(
                activePlan: activePlan,
                date: dateWithMidday
            )
            
            saveDayRecordToHistory(missedDayRecord)
            print("Создан DayRecord для пропущенного дня: \(missedDate)")
        }
        
        // Создаём новый DayRecord на сегодня
        createNewDayRecordForToday()
    }
    
    /// Создаёт новый DayRecord на сегодня с текущим активным планом
    private func createNewDayRecordForToday() {
        guard let activePlan = getWhichActivePlanIs() else {
            print("Невозможно создать DayRecord на сегодня - нет активного плана")
            return
        }
        
        let newDayRecord = DayRecord(activePlan: activePlan)
        saveCurrentDayRecord(newDayRecord)
        print("Создан новый DayRecord на сегодня: \(newDayRecord.date)")
    }
}

// MARK: - Storage Cases Enum
enum StorageCases: String {
    case allPlans = "Plan"
    case currentDayRecord = "currentDayRecord"
    case dayRecordsHistory = "DayRecordsHistory"
    case activePlan = "activePlan"
}
