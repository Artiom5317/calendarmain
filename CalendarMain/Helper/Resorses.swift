//
//  Resorses.swift
//  CalendarMain
//
//  Created by Artiom on 20.01.26.
//

import UIKit



enum Resources {
    
    enum Colors {
        static var mainGreenActive = UIColor(hexString: "#46eb34")
        static var inactive = UIColor(hexString: "#727571")
        
//        static var separator = UIColor(hexString: "E8ECEF")
        static var separator = UIColor.separator
        
//        static var backgroundColor = UIColor.white
        static var backgroundColor = UIColor.systemBackground
        
//        static var labelColor = UIColor.black
        static var labelColor = UIColor.systemGreen
    }
    
    
    enum Strings {
        enum TabBar {
            static var home = "Daily"
            static var plan: String = "Plan"
            static var calendar: String = "Calendar"
        }
    }
    
    enum Images {
        enum TabBar {
            static var home = UIImage(systemName: "house.fill")
            static var plan = UIImage(systemName: "document.fill")
            static var calendar = UIImage(systemName: "calendar.badge.checkmark")
        }
    }
    
}


enum TableViewIdentifier: String {
    case plansTableView = "PlansTableView"
    //continue
    case createTasksIdentifier = "TasksIdentififer"
    case dailyTasksIdentifier = "DailyTasksIdentifier"
    
    case detailsTasksIdentifier = "detailsTasksIdentifier"
}
