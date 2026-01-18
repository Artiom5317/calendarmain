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
    var onDoneButtonTapped: (() -> Void)?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    
    private func setupUI() {
        contentView.addSubviews(taskLabel, taskDoneButton)
        taskLabel.translatesAutoresizingMaskIntoConstraints = false
        taskLabel.font = .systemFont(ofSize: 20, weight: .regular)
        taskDoneButton.translatesAutoresizingMaskIntoConstraints = false
        taskDoneButton.contentHorizontalAlignment = .fill
        taskDoneButton.contentVerticalAlignment = .fill
        setupButton()
        setupConstraints()
    }
    
    func setupCell(with data: Task) {
        taskLabel.text = data.toDo
        let imageName = data.isCompleted ? "checkmark.circle" : "circle"
        taskDoneButton.setImage(UIImage(systemName: imageName), for: .normal)
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
        taskDoneButton
            .addAction(
                UIAction(handler: { [weak self] _ in
                    guard let self = self else { return }
                    self.onDoneButtonTapped?()
                }),
                for: .touchUpInside
            )
    }
    func setupConstraints() {
        NSLayoutConstraint.activate([
            //button
            taskDoneButton.widthAnchor.constraint(equalToConstant: 40),
            taskDoneButton.heightAnchor.constraint(equalToConstant: 40),
            taskDoneButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            taskDoneButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            
            //TaskLabel
            taskLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            taskLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            taskLabel.trailingAnchor.constraint(equalTo: taskDoneButton.leadingAnchor, constant: -5),
            taskLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)

        ])
    }
}

