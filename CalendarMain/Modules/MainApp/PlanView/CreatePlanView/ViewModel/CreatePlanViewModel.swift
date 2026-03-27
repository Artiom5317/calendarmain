//
//  CreatePlanViewModel.swift
//  CalendarMain
//
//  Created by Artiom on 22.01.26.
//

import Foundation


// text Field
// TableView -> [Task]



protocol CreatePlanViewModelProtocol: AnyObject {
    
    //Методы для UITableViewDataSource
    var tasksCount: Int {get}
    func taskData(from index: Int) -> Task
    
    // дергаем функцию что менять текст в [Task]
    func taskTextChanged(for index: Int, text: String)
    // дергаем функция чтобы менять текст
    func titleHasChanged(to string: String)
    // Добавление/Удаление задачи
    func addTask()
    func removeTask(at index: Int)
    // Вызываем при удаления эллемента в массиве (при добавление не трогаем)
    var onDataUpdated: ((Int) -> Void)? { get set }
    // Создание + сохранение плана в БД
    func savePlan()
    // проверочные функции
    func printTasks()
}



class CreatePlanViewModel: CreatePlanViewModelProtocol {
    private(set) var tasks: [Task] = [Task(toDo: "")]
    
    var onDataUpdated: ((Int) -> Void)?
    
    var tasksCount: Int {
        tasks.count
    }
    func taskData(from index: Int) -> Task {
        return tasks[index]
    }
    
    func taskTextChanged(for index: Int, text: String) {
        tasks[index].toDo = text
    }
    
    
    private(set) var planTitle: String = ""
    
    
    func addTask() {
        let task = Task(toDo: "")
        tasks.append(task)
    }
    
    func removeTask(at index: Int) {
        tasks.remove(at: index)
        onDataUpdated?(index)
    }

    func titleHasChanged(to string: String) {
        planTitle = string
    }
    
}



extension CreatePlanViewModel {
    func printTasks() {
        print(tasks)
    }
    
    func savePlan() {
        var plan = makePlan()
        StorageManager.shared.addNewPlan(plan: &plan)
    }
    
    
   private func makePlan() -> Plan {
        let plan = Plan(title: planTitle, tasks: tasks)
        return plan
    }
    

}

