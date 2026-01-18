//
//  CreatePlanViewController.swift
//  CalendarMain
//
//  Created by Artiom on 22.01.26.
//

import UIKit

class CreatePlanViewController: UIViewController {
    
    let viewModel: CreatePlanViewModelProtocol
    
    init(viewModel: CreatePlanViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("asdasd")
    }
    
    private let titleTextField: UITextField = .createTextField(placeHolder: "Название Плана")
    private let tasksTableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    
    private func setupUI() {
        view.backgroundColor = Resources.Colors.backgroundColor
    }

    
    private func setupTasksTableView() {
        tasksTableView.register(TasksCell.self, forCellReuseIdentifier:TasksCell.identifier)
        tasksTableView.dataSource = self
    }
    
}




extension CreatePlanViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
    
}
