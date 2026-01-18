//
//  HomeCoordinator.swift
//  CalendarMain
//
//  Created by Artiom on 25.02.26.
//


// HomeCoordinator.swift
final class HomeCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewModel = MainViewModel()
        let viewController = MainViewController(mainViewModel: viewModel)
        viewController.coordinator = self // Добавим свойство в MainViewController
        navigationController.setViewControllers([viewController], animated: false)
    }
    
    // Методы для навигации
    func showDetails(for item: SomeItem) {
        let detailsVC = DetailsViewController(item: item)
        navigationController.pushViewController(detailsVC, animated: true)
    }
}