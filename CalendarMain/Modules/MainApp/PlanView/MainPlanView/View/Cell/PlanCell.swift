//
//  PlanCell.swift
//  CalendarMain
//
//  Created by Artiom on 27.01.26.
//

import UIKit

class PlanCell: UITableViewCell {
    
    static let indentifier: String = TableViewIdentifier.plansTableView.rawValue
    
    
    let planTitle: UILabel = .createLabel()
    let verticalStackView: UIStackView = UIStackView()
    let selectedPlanButton: UIButton = UIButton()
    
    var onSelectedPlanButtonTapped: (() -> Void)?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupConstraints()
        setupButtonAction()
    }
    
    

    private func setupButtonAction() {
        selectedPlanButton.addAction(UIAction(handler: { [weak self] _ in
            guard let self = self else { return }
            self.onSelectedPlanButtonTapped?()
        }), for: .touchUpInside)
    }
    
    func setupUI() {
        planTitle.font = .systemFont(ofSize: 20, weight: .bold)
        planTitle.translatesAutoresizingMaskIntoConstraints = false
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        //stack
        verticalStackView.axis = .vertical
        verticalStackView.spacing = 8
        verticalStackView.alignment = .leading
        verticalStackView.distribution = .fill
        //Button
        
        
        selectedPlanButton.translatesAutoresizingMaskIntoConstraints = false
        selectedPlanButton.layer.cornerRadius = 20
//        selectedPlanButton.backgroundColor = .gray
        selectedPlanButton.clipsToBounds = true
//        selectedPlanButton.contentMode = .scaleToFill
        selectedPlanButton.contentMode = .scaleAspectFit
        selectedPlanButton.contentHorizontalAlignment = .fill
        selectedPlanButton.contentVerticalAlignment = .fill
        selectedPlanButton.tintColor = Resources.Colors.mainGreenActive
        
        contentView.addSubviews(planTitle, verticalStackView, selectedPlanButton)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            planTitle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            planTitle.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            verticalStackView.topAnchor.constraint(equalTo: planTitle.bottomAnchor, constant: 16),
            verticalStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            verticalStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -50),
            // Добавьте это в setupConstraints, чтобы ячейка понимала свою высоту:
            verticalStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            selectedPlanButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            selectedPlanButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            selectedPlanButton.widthAnchor.constraint(equalToConstant: 40),
            selectedPlanButton.heightAnchor.constraint(equalToConstant: 40),


        ])
    }
    
    
    
    func setupCell(with data: Plan) {
        planTitle.text = data.title
        //Удаление старого
        verticalStackView.arrangedSubviews.forEach { view in
            view.removeFromSuperview()
        }
        // Добавление нового
        data.tasks.enumerated().forEach { index, task in
            let taskLabel: UILabel = .createLabel(text: "\(index + 1). \(task.toDo)", NOL: 1)
            verticalStackView.addArrangedSubview(taskLabel)
        }

        //Настройка кнопки
        let imageName = data.isActive ? PlanIcon.active : PlanIcon.inactive
        selectedPlanButton.setImage(UIImage(systemName: imageName), for: .normal)
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



enum PlanIcon {
    static let active = "checkmark.circle"
    static let inactive = "circle"
}
