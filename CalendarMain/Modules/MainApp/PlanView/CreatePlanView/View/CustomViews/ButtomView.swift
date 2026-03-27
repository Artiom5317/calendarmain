//
//  ButtomView.swift
//  CalendarMain
//
//  Created by Artiom on 22.01.26.
//

import UIKit




class ButtomView: UIView {
    
    enum ButtonAction {
        case addTask
        case savePlan
    }
    
    let addTaskButton: UIButton = PrimaryButton()
    let savePlanButton: UIButton = PrimaryButton()
    
    

    
    var buttonsTapped: ((ButtonAction) -> Void)?
    
    
    
    let horizontalStack: UIStackView = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    func setupUI() {
        setupButtons()
        setupStack()
        setupLayout()
    }
    
    func setupButtons() {
        addTaskButton.setTitle("Добавить Задачу", for: .normal)
        savePlanButton.setTitle("Сохранить", for: .normal)
        
        // Назначаем UIAction вместо addTarget
        addTaskButton.addAction(
            UIAction { [weak self] _ in
                self?.buttonsTapped?(ButtonAction.addTask)
            },
            for: .touchUpInside
        )
        
        savePlanButton.addAction(
            UIAction { [weak self] _ in
                self?.buttonsTapped?(ButtonAction.savePlan)
            },
            for: .touchUpInside
        )
    }
    

    

    
    func setupStack() {
        horizontalStack.axis = .horizontal
        horizontalStack.alignment = .fill
        horizontalStack.distribution = .fillEqually
        horizontalStack.spacing = 12

    }
    
    func setupLayout() {
        horizontalStack.addArrangedSubview(addTaskButton)
        horizontalStack.addArrangedSubview(savePlanButton)
        addTaskButton.translatesAutoresizingMaskIntoConstraints = false
        savePlanButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(horizontalStack)
        self.disableTamic()
        
        NSLayoutConstraint.activate([
            horizontalStack.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            horizontalStack.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            horizontalStack.topAnchor.constraint(equalTo: topAnchor),
            horizontalStack.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            addTaskButton.heightAnchor.constraint(equalToConstant: 47),
            savePlanButton.heightAnchor.constraint(equalToConstant: 47),
            
            
        ])
    }
    
}


