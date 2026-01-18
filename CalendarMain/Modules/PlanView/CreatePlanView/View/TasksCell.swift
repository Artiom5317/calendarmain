//
//  TasksCell.swift
//  CalendarMain
//
//  Created by Artiom on 22.01.26.
//

import UIKit

class TasksCell: UITableViewCell {
    
    static let identifier: String = TableViewIdentifier.createTasksIdentifier.rawValue
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
