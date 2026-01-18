//
//  MainViewController.swift
//  CalendarMain
//
//  Created by Artiom on 18.01.26.
//

import UIKit

//#warning("ыыы")
class MainViewController: UIViewController {
    
    private let mainViewModel: MainViewModelProtocol!
    
    init(mainViewModel: MainViewModelProtocol) {
        self.mainViewModel = mainViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    #warning("Верлно ли указываю проперти тут после req init? ")
    //Properties
    let dailyTasksTableView: UITableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
        setupNavigationBar()
        mainViewModel.getDailyTasks()
    }
    
    
    func setupUI() {
        setupTableView()
        view.addSubview(dailyTasksTableView)
        dailyTasksTableView.translatesAutoresizingMaskIntoConstraints = false
        setupConstraints()
    }
    
    
    func setupTableView() {
        dailyTasksTableView.frame = .zero
        dailyTasksTableView.register(DailyTasksTableViewCell.self, forCellReuseIdentifier: DailyTasksTableViewCell.identifier)
//        dailyTasksTableView.tableHeaderView = UIView()
        dailyTasksTableView.dataSource = self
        dailyTasksTableView.delegate = self
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            dailyTasksTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            dailyTasksTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            dailyTasksTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            dailyTasksTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50)
        ])
    }
    

}

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        mainViewModel.dailyTasksCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DailyTasksTableViewCell.identifier, for: indexPath) as! DailyTasksTableViewCell
        guard let data = mainViewModel.dailyTasksData(from: indexPath.row) else { return UITableViewCell() }
        cell.setupCell(with: data)
        return cell
    }
    
    
}










private extension MainViewController {
    func setupNavigationBar() {
        let dateLabel: UILabel = .createLabel(text: mainViewModel.dayAndMonthText)
        dateLabel.font = .systemFont(ofSize: 40, weight: .bold)
        navigationItem.titleView = dateLabel
        navigationController?.navigationBar.layer.borderWidth = 1
        navigationController?.navigationBar.layer.borderColor = Resources.Colors.separator.cgColor
        
    }
    
    func setupViewModelBindings() {
        mainViewModel.onDataUpdated = { [weak self] in
            self?.dailyTasksTableView.reloadData()
        }
    }
}
