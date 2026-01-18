//
//  CalendarViewModel.swift
//  CalendarMain
//
//  Created by Artiom on 18.01.26.
//

import Foundation


#warning("Зачем писать private(set)? можно же просто private. а почему не get еще?")

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
