//
//  TasksCell.swift
//  CalendarMain
//
//  Created by Artiom on 22.01.26.
//

import UIKit

final class TasksCell: UITableViewCell {
    
    static let identifier: String = TableViewIdentifier.createTasksIdentifier.rawValue
    let taskTextField: UITextField = .createTextField(placeHolder: "Введите задачу")
    
    var onTextUpdate: ((String) -> Void)?
    

    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        taskTextField.addTarget(self, action: #selector(textChanged), for: .editingChanged)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func textChanged() {
        onTextUpdate?(taskTextField.text ?? "")
        
    }
    
    func setupUI() {
        contentView.addSubview(taskTextField)
        taskTextField.translatesAutoresizingMaskIntoConstraints = false
        setupConstraints()
        
    }
//    
//    private func setupConstraints() {
////        NSLayoutConstraint.activate([
////            taskTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
////            taskTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
////            taskTextField.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
////            taskTextField.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
//////            taskTextField.heightAnchor.constraint(equalToConstant: 47),
////        ])
//
//    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            taskTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            taskTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            taskTextField.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            taskTextField.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            taskTextField.heightAnchor.constraint(greaterThanOrEqualToConstant: 47) // Минимум 47
        ])
    }
    
}
