//
//  CalendarViewModel.swift
//  CalendarMain
//
//  Created by Artiom on 18.01.26.
//

import Foundation




protocol CalendarViewModelProtocol: AnyObject{
    func getHistoryDayRecord()
    var historyDayRecords: [DayRecord] { get set }
    var onDataUpdated: (() -> Void)? { get set }
}

class CalendarViewModel: CalendarViewModelProtocol {
    
    var historyDayRecords: [DayRecord] = []
    var onDataUpdated: (() -> Void)?
    
    func getHistoryDayRecord() {
        historyDayRecords = StorageManager.shared.getDayRecordsHistory()
        onDataUpdated?()
    }
}
