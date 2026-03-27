//
//  CreatePlanViewController.swift
//  CalendarMain
//
//  Created by Artiom on 22.01.26.
//

import UIKit

#warning("""
проверку на то что текст не пустой в заголовке и в таксках
рзаобраться с отдельными функциями с makePlan() - Plan
как работает throws и что лучше использовать именно в этой задаче
разобраться стоит ли 
""")

class CreatePlanViewController: UIViewController {
    
    
    lazy var imageDelete: UIImageView = UIImageView(image: UIImage(systemName: "plus"))
    
    
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
    private let bottomView = ButtomView()
    
    lazy var myScrollView: UIScrollView = {
        
        return $0
    }(UIScrollView())
    
    private func closeKeyboard() {
        let tap = UITapGestureRecognizer(
            target: self,
            action: #selector(hideKeyboard)
        )
        tap.cancelsTouchesInView = false // важно!
        view.addGestureRecognizer(tap)
    }

    @objc private func hideKeyboard() {
        view.endEditing(true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
//        closeKeyboard()
        hidesBottomBarWhenPushed = true
        setupUI()
        setupBindings()
        
        setupButtomViewBindings()
        titleTextField.addTarget(self, action: #selector(titleHasChanged), for: .editingChanged)
    }
    
    @objc func titleHasChanged() {
        viewModel.titleHasChanged(to: titleTextField.text ?? "No Title...")
    }
    
    private func setupButtomViewBindings() {
        
        bottomView.buttonsTapped = { [weak self] btn in
            guard let self = self else { return }
            switch btn {
            case.addTask:
                viewModel.addTask()
                self.reloadTableView()
            case .savePlan:
                print("Save Plun Buttom Tapped")
                self.viewModel.savePlan()
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    


    
    private func setupUI() {
        view.backgroundColor = Resources.Colors.backgroundColor
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleKeyboard),
            name: UIResponder.keyboardWillChangeFrameNotification,
            object: nil
        )
        
        setupTasksTableView()
        view.addSubviews(titleTextField, tasksTableView, bottomView)
        view.disableTamic()
        setupLayout()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    
    private func setupTasksTableView() {
        tasksTableView.register(TasksCell.self, forCellReuseIdentifier:TasksCell.identifier)
        tasksTableView.dataSource = self
        tasksTableView.delegate = self
    }
    private func setupLayout() {
        NSLayoutConstraint.activate([
            titleTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            titleTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            titleTextField.heightAnchor.constraint(equalToConstant: 48),
            titleTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            
            tasksTableView.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 30),
            tasksTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            tasksTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            tasksTableView.bottomAnchor.constraint(equalTo: bottomView.topAnchor, constant: -20),
            
            bottomView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            bottomView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            bottomView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8),
//            bottomView.bottomAnchor.constraint(equalTo: view.keyboardLayoutGuide.topAnchor, constant: -8)
        ])
    }
    
    
    @objc private func handleKeyboard(_ notification: Notification) {
        guard
            let info = notification.userInfo,
            let frame = info[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect
        else { return }

        let keyboardHeight = max(0, view.bounds.height - frame.origin.y)

        additionalSafeAreaInsets.bottom = keyboardHeight
    }
    
    
    private func reloadTableView() {
        tasksTableView.reloadData()
    }
    
}

private extension CreatePlanViewController {
    
    func setupBindings() {
        viewModel.onDataUpdated = { [weak self] atIndex in
            guard let self = self else { return }
            let indexPath = IndexPath(row: atIndex, section: 0)
            self.tasksTableView.deleteRows(at: [indexPath], with: .right)
        }
    }
}





extension CreatePlanViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.tasksCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TasksCell.identifier, for: indexPath) as! TasksCell
        let taskData = viewModel.taskData(from: indexPath.row)
        cell.taskTextField.text = taskData.toDo
        
        cell.onTextUpdate = { [weak self] text in
            guard let self = self else { return }
            self.viewModel.taskTextChanged(for: indexPath.row, text: text)
//            viewModel.printTasks()
        }
        

//        cell.selectionStyle = .none
        return cell
    }
    
    
}


extension CreatePlanViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(
            style: .destructive,
            title: "Delete"
        ) { [weak self] _, _, completion in
            self?.viewModel.removeTask(at: indexPath.row)
            completion(true)
        }

        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        
        configuration.performsFirstActionWithFullSwipe = true
        
        return configuration
        
    }
    
}

