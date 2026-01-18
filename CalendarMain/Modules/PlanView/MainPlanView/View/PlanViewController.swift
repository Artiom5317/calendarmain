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
    }
    

    
    func showPlansOrMessage() {
        let isEmpty = viewModel.isEmpty

        plansTableView.isHidden = isEmpty
        mainInformLabel.isHidden = !isEmpty

        if !isEmpty {
            plansTableView.reloadData()
        }
    }
    
    
    func reloadTableView() {
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
        #warning("Тут можно без него если через AutoLayout пишу?")
//        plansTableView.frame = view.frame
        plansTableView.register(UITableViewCell.self, forCellReuseIdentifier: TableViewIdentifier.plansTableView.rawValue)
        plansTableView.dataSource = self
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
    
    

    
//    @objc func addPlanTapped() {
//        viewModel.didTapNavigation(.add)
//    }
//    
//    @objc func infoButtonTapped() {
//        viewModel.didTapNavigation(.info)
//    }
}


private extension PlanViewController {
    func setupBindings() {
        viewModel.onDataUpdated = { [weak self] in
            guard let self = self else { return }
            self.showPlansOrMessage()
        }
        
        viewModel.onNavigate = { [weak self] nav in
            guard let self = self else { return }
            self.handleNavigation(nav)
        }
    }
    
}

private extension PlanViewController {

    func handleNavigation(_ nav: PlanNavigation) {
        switch nav {
        case .add:
//            print("Tapped Add")
            let vc = UIViewController()
            vc.navigationItem.title = "ТУТ ПИШЕМ ПЛАНЫ"
            vc.view.backgroundColor = .red
            vc.tabBarController?.isTabBarHidden = true
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




extension PlanViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewIdentifier.plansTableView.rawValue, for: indexPath)
        
        return cell
    }
    
    
}
