//
//  DayDetailtsViewModel.swift
//  CalendarMain
//
//  Created by Artiom on 07.02.26.
//

import Foundation




protocol DayDetailtsViewModelProtocol: AnyObject {
    var dayDetails: DayRecord? { get }
    
    var numberOfTasks: Int { get }
    func getTasksString(from index: Int) -> Task?
    
    var getStringOfDateOfCompletion: String { get }
}



class DayDetailtsViewModel: DayDetailtsViewModelProtocol {

    
    
    var dayDetails: DayRecord?
    
    
    init(dayDetails: DayRecord?) {
        self.dayDetails = dayDetails
    }
    
    var numberOfTasks: Int {
        guard let dayDetails else { return 0 }
        return dayDetails.activePlan.tasks.count
    }
    
    func getTasksString(from index: Int) -> Task? {
        guard let dayDetails else { return nil}
        let result = dayDetails.activePlan.tasks[index]
//        return result
        return result
    }
    
    var getStringOfDateOfCompletion: String {
        guard let date = dayDetails?.dateOfCompetion else { return "" }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        let timeString = formatter.string(from: date)
        return timeString
    }
}
