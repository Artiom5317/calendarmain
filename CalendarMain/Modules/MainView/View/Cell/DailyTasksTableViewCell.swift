//
//  DailyTasksTableViewCell.swift
//  CalendarMain
//
//  Created by Artiom on 28.01.26.
//

import UIKit

class DailyTasksTableViewCell: UITableViewCell {
    
    static let identifier: String = TableViewIdentifier.dailyTasksIdentifier.rawValue
    
    
    let taskLabel: UILabel = .createLabel()
    let taskDoneButton: UIButton = UIButton()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    
    private func setupUI() {
        taskLabel.translatesAutoresizingMaskIntoConstraints = false
        taskDoneButton.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubviews(taskLabel, taskDoneButton)
        setupButton()
        setupConstraints()
    }
    
    func setupCell(with data: Task) {
        taskLabel.text = data.toDo
    }
    

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


private extension DailyTasksTableViewCell {
    func setupButton() {
        taskDoneButton.layer.cornerRadius = 20
        taskDoneButton.clipsToBounds = true
        taskDoneButton.tintColor = Resources.Colors.mainGreenActive
    }
    func setupConstraints() {
        NSLayoutConstraint.activate([
            //button
            taskDoneButton.widthAnchor.constraint(equalToConstant: 40),
            taskDoneButton.heightAnchor.constraint(equalToConstant: 40),
            taskDoneButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            taskDoneButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            
            //TaskLabel
            taskLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            taskLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            taskLabel.trailingAnchor.constraint(equalTo: taskDoneButton.leadingAnchor, constant: -5),
            
            
        
            

        ])
    }
    
    
}

#warning("Стоит ли задать bottomAnchor для taskLabel")
