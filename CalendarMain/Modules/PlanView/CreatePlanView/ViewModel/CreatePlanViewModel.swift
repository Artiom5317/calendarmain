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
    var tasksCount: Int {get}
}



class CreatePlanViewModel: CreatePlanViewModelProtocol {
    private(set) var tasks: [Task] = [Task(toDo: "")]
    var tasksCount: Int {
        tasks.count
    }
    private(set) var planTitle: String? = nil
    
    
}
