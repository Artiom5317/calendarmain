//
//  PlanViewController.swift
//  CalendarMain
//
//  Created by Artiom on 20.01.26.
//

import UIKit

final class PlanViewController: UIViewController {
    
    let viewModel: PlanViewModelProtocol
    
    ///Properties:
    private let plansTableView: UITableView = UITableView()
    private let mainInformLabel: UILabel = .createLabel(text: "Пока нет планов", isHidden: false)
    
    var shouldOpenAddScreen = false
    
    init(viewModel: PlanViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
//        bindOnNavigate()
        setupBindings()
        viewModel.fetchPlans()
        print("ПРОГРУЗИЛСЯ ТОЛЬКО КААК ОТКРЫЛ")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        if shouldOpenAddScreen {
//            shouldOpenAddScreen = false // Сбрасываем флаг
//            viewModel.onNavigate?(PlanNavigation.add)
//        }
    }
    
    override func viewIsAppearing(_ animated: Bool) {
        super.viewIsAppearing(animated)
        if shouldOpenAddScreen {
            shouldOpenAddScreen = false // Сбрасываем флаг
//            viewModel.onNavigate?(PlanRoute.add)
        }

    }
    
    func showPlansOrMessage() {
        let isEmpty = viewModel.isEmpty

        plansTableView.isHidden = isEmpty
        mainInformLabel.isHidden = !isEmpty

        if !isEmpty {
//            plansTableView.reloadData()
            reloadTableView()
        }
    }
    
    
    func reloadTableView() {
        plansTableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetchPlans()
        plansTableView.reloadData()
    }

}


private extension PlanViewController {
    
    func setupUI() {
        view.backgroundColor = Resources.Colors.backgroundColor
        setupTableView() // 1
        navigationBarItem() // 2
        setupLayout()
    }
    
    func setupTableView() {
        plansTableView.register(PlanCell.self, forCellReuseIdentifier: PlanCell.indentifier)
        plansTableView.dataSource = self
        plansTableView.delegate = self
    }
    
    func navigationBarItem() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "plus"),
            style: .done,
            target: self,
            action: #selector(addPlanTapped)
        )
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "Info",
            style: .done,
            target: self,
            action: #selector(infoButtonTapped)
        )
    }
    
    func setupLayout() {
        view.addSubviews(plansTableView, mainInformLabel)
        view.disableTamic()
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            plansTableView.topAnchor.constraint(equalTo: view.topAnchor),
            plansTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            plansTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            plansTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            mainInformLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainInformLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    

}


private extension PlanViewController {
    func setupBindings() {
        viewModel.onDataUpdated = { [weak self] in
            guard let self = self else { return }
            self.showPlansOrMessage()
        }
        
//        viewModel.onNavigate = { [weak self] nav in
//            guard let self = self else { return }
//            self.handleNavigation(nav)
//        }
    }
    
}

private extension PlanViewController {

    func handleNavigation(_ nav: PlanRoute) {
        switch nav {
        case .add:
            let vc = CreatePlanViewController(viewModel: CreatePlanViewModel())
            vc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(vc, animated: true)
            
        case .info:
            let vc = UIViewController()
            vc.view.backgroundColor = Resources.Colors.mainGreenActive
            present(vc, animated: true)
        }
    }
    
    @objc func addPlanTapped() {
        viewModel.didTapNavigation(.add)
    }

    @objc func infoButtonTapped() {
        viewModel.didTapNavigation(.info)
    }
}




extension PlanViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.plansCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: PlanCell.indentifier, for: indexPath) as! PlanCell
        let data = viewModel.planData(from: indexPath.row)
        cell.setupCell(with: data)

        cell.onSelectedPlanButtonTapped = { [weak self] in
            guard let self = self else { return }
//            self.viewModel.changeIsActivePlan(at: indexPath.row)
            //open alert

            let alert = UIAlertController(
                title: "Предупреждение ‼️",
                message: "Это действие изменит активный план. Вы согласны?",
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(title: "Нет", style: .cancel))
            
//            alert.addAction(UIAlertAction(title: "ОК", style: .destructive))
            alert.addAction(UIAlertAction(title: "Согласен", style: .destructive, handler: { _ in
                self.viewModel.changeIsActivePlan(at: indexPath.row)
            }))

            present(alert, animated: true)
            
        }
        
        return cell
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}


#warning("""
class PlanViewController: UIViewController {
    var viewModel: PlanViewModelProtocol!
    weak var coordinator: PlanCoordinator?  // Слабая ссылка!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
        setupUI()
    }
    
    private func setupBindings() {
        viewModel.onDataUpdated = { [weak self] in
            self?.updateUI()
        }
    }
    
    @objc private func addPlanTapped() {
        coordinator?.showAddPlan()
    }
    
    @objc private func infoButtonTapped() {
        coordinator?.showInfo()
    }
    
    // Остальные методы UI
    private func setupUI() { /* ... */ }
    private func updateUI() { /* ... */ }
}

Это код который говорит с координтаором Алиса.
""")
