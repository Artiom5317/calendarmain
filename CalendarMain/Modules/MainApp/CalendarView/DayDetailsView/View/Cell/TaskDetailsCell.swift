//
//  TaskDetailsCell.swift
//  CalendarMain
//
//  Created by Artiom on 07.02.26.
//

import UIKit

class TaskDetailsCell: UITableViewCell {
    
    static let identifier: String = TableViewIdentifier.detailsTasksIdentifier.rawValue
    
    let taskText: UILabel = .createInfoLabel()
    let infoView: UIImageView = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    
    
    private func setupUI() {
        setupImage()
        contentView.addSubviews(taskText, infoView)
        taskText.translatesAutoresizingMaskIntoConstraints = false
        infoView.translatesAutoresizingMaskIntoConstraints = false
        setupConstraints()
    }
    
    
    private func setupImage() {
        infoView.layer.cornerRadius = 15
        infoView.clipsToBounds = true
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            infoView.widthAnchor.constraint(equalToConstant: 30),
            infoView.heightAnchor.constraint(greaterThanOrEqualToConstant: 30),
            infoView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            infoView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            infoView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            taskText.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            taskText.trailingAnchor.constraint(equalTo: infoView.leadingAnchor, constant: -8),
            taskText.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    
    func setupCell(with data: Task) {
        let imageName = data.isCompleted ? "checkmark.circle.fill" : "xmark.circle.fill"
        let imageColor = data.isCompleted ? UIColor.systemGreen : UIColor.systemRed
        
        infoView.image = UIImage(systemName: imageName)
        infoView.tintColor = imageColor
        
        taskText.text = data.toDo
    }
    
    
    
    
    
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
