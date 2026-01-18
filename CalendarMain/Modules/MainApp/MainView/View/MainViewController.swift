//
//  MainViewController.swift
//  CalendarMain
//
//  Created by Artiom on 18.01.26.
//

import UIKit

//#warning("ыыы")
final class MainViewController: UIViewController {

    // MARK: - Dependencies

    private let mainViewModel: MainViewModelProtocol

    // MARK: - UI

    // Properties
    let dailyTasksTableView: UITableView = UITableView()
    let informationButton: UIButton = PrimaryButton()

    // MARK: - Init

    init(mainViewModel: MainViewModelProtocol) {
        self.mainViewModel = mainViewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle
    


    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        setupUI()
        setupNavigationBar()
        setupViewModelBindings()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        mainViewModel.getDailyTasks()
    }
}

// MARK: - Setup UI

private extension MainViewController {

    func setupUI() {
        setupTableView()
        

        view.addSubviews(dailyTasksTableView, informationButton)

        dailyTasksTableView.translatesAutoresizingMaskIntoConstraints = false
        informationButton.translatesAutoresizingMaskIntoConstraints = false
        informationButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
        setupConstraints()
    }

    func setupTableView() {
        dailyTasksTableView.frame = .zero
        dailyTasksTableView.register(
            DailyTasksTableViewCell.self,
            forCellReuseIdentifier: DailyTasksTableViewCell.identifier
        )
        // dailyTasksTableView.tableHeaderView = UIView()
        dailyTasksTableView.dataSource = self
        dailyTasksTableView.delegate = self
    }

//    func setupButton() {
//        informationButton.layer.borderColor = UIColor.black.cgColor
//        informationButton.layer.borderWidth = 1
//    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            dailyTasksTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            dailyTasksTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            dailyTasksTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            dailyTasksTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),

            informationButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            informationButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            informationButton.heightAnchor.constraint(equalToConstant: 70)
        ])
    }
}

// MARK: - UITableViewDataSource / UITableViewDelegate

extension MainViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        #warning("Вызывется не один раз сам print. почему?")
        print("Rows count: \(mainViewModel.dailyTasksCount)") // Должно быть > 0
        return mainViewModel.dailyTasksCount
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(
            withIdentifier: DailyTasksTableViewCell.identifier,
            for: indexPath
        ) as! DailyTasksTableViewCell

        guard let data = mainViewModel.dailyTasksData(from: indexPath.row) else {
            return UITableViewCell()
        }

        cell.setupCell(with: data)

        cell.onDoneButtonTapped = { [weak self] in
            guard let self = self else { return }
            self.mainViewModel.taskIsComplete(at: indexPath.row)
            self.dailyTasksTableView.reloadRows(at: [indexPath], with: .automatic)
        }

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - Navigation & Bindings

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
            guard let self = self else { return }

            // if mainViewModel.isDayComplete
            guard let isDayComplete = mainViewModel.isDayComplete else {
                // HIDE ALL and Show that NO ACTIVE PLAN YET. go and create
                // ✅
                showScreenNoActivePlanYet()
                return
            }

            if isDayComplete {
                // Show CONGRATULATION SCREEN✅
                showCongratulationScreen()
            } else {
                // Reload TABle view. Пока без функции
                dailyTasksTableView.isHidden = false
                informationButton.isHidden = true
                dailyTasksTableView.reloadData()
            }
        }
    }
}

// MARK: - Screens

private extension MainViewController {

    // 1
    func showScreenNoActivePlanYet() {
        informationButton.setTitle("Нет плана. Для создания нажмите", for: .normal)
        informationButton.isHidden = false
        dailyTasksTableView.isHidden = true
        
        informationButton.removeTarget(nil, action: nil, for: .allEvents)
        informationButton.addTarget(self, action: #selector(setAction), for: .touchUpInside)
    }
    
    @objc func setAction() {
        guard let tabBar = self.tabBarController else { return }
        print("111")
        // 1. Находим нужный контроллер
        if let navVC = tabBar.viewControllers?[1] as? UINavigationController,
           let secondVC = navVC.viewControllers.first as? PlanViewController {

            // 2. Сбрасываем навигацию на корень (если там было что-то открыто)
            navVC.popToRootViewController(animated: false)

            // 3. Говорим контроллеру: "Когда появишься — открой добавление"
            secondVC.shouldOpenAddScreen = true
        }

        // 4. Переключаем таб
        tabBar.selectedIndex = 1
    }

    // 2
    func showCongratulationScreen() {
        informationButton.removeTarget(nil, action: nil, for: .allEvents)
        informationButton.setTitle("День завершен. Поздравляю!", for: .normal)
        informationButton.isHidden = false
        dailyTasksTableView.isHidden = true
    }
}



















































class Test {
    var value: String? = "test"
    func check() {
        guard let value else { return } // Ошибка здесь!
        print(value)
    }
}



final class GradientView: UIView {

    private let gradient = CAGradientLayer()

    override init(frame: CGRect) {
        super.init(frame: frame)

        gradient.colors = [UIColor.green.cgColor, UIColor.purple.cgColor]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 1, y: 1)

        layer.insertSublayer(gradient, at: 0)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        gradient.frame = bounds
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
