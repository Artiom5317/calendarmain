//
//  DayDetailsViewController.swift
//  CalendarMain
//
//  Created by Artiom on 07.02.26.
//

import UIKit

class DayDetailsViewController: UIViewController {
    
    let viewModel: DayDetailtsViewModelProtocol
    
    init(viewModel: DayDetailtsViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    
    
    let tasksTableView: UITableView = UITableView()
    
    
    private let nameOfPlanText: UILabel = .createInfoLabel()
    private let dateOfCompletionText: UILabel = .createInfoLabel()
    private let vStack: UIStackView = UIStackView()
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.title = viewModel.dayDetails?.activePlan.title
        setupUI()
    
    }
    
    
    private func setupUI() {
        setupTableView()
        setupVStack()
        view.addSubviews(vStack, tasksTableView)
        setupConstraints()
        setupLabelText()
    }
    
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            vStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            vStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            vStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            
            tasksTableView.topAnchor.constraint(equalTo: vStack.bottomAnchor, constant: 8),
            tasksTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tasksTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tasksTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    
    private func setupTableView() {
        tasksTableView.translatesAutoresizingMaskIntoConstraints = false
        tasksTableView.dataSource = self
        tasksTableView.register(TaskDetailsCell.self, forCellReuseIdentifier: TaskDetailsCell.identifier)
    }
    
    private func setupVStack() {
        vStack.translatesAutoresizingMaskIntoConstraints = false
        vStack.axis = .vertical
        vStack.spacing = 8
        vStack.alignment = .leading
        vStack.distribution = .equalSpacing
        vStack.addArrangedSubview(nameOfPlanText)
        vStack.addArrangedSubview(dateOfCompletionText)
    }
    
    private func setupLabelText() {
        nameOfPlanText.text = "Название Плана: \(viewModel.dayDetails?.activePlan.title ?? "nil")"
        dateOfCompletionText.text = "Время завершения плана: \(self.viewModel.getStringOfDateOfCompletion)"
        nameOfPlanText.translatesAutoresizingMaskIntoConstraints = false
        dateOfCompletionText.translatesAutoresizingMaskIntoConstraints = false
        
    }
}



extension DayDetailsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.viewModel.numberOfTasks
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableViewIdentifier.detailsTasksIdentifier.rawValue, for: indexPath) as? TaskDetailsCell else {
            return UITableViewCell()
        }
        

        guard let data = self.viewModel.getTasksString(from: indexPath.row) else { return UITableViewCell() }
        cell.setupCell(with: data)

        return cell
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Задачи"
    }
}



#warning("safeAreaLayoutGuide Почитать про эти разницы!")
