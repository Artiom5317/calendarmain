//
//  HomeCoordinator.swift
//  CalendarMain
//
//  Created by Artiom on 25.02.26.
//


import UIKit



// HomeCoordinator.swift
final class HomeCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    var onExit: (() -> Void)?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewModel = MainViewModel()
        let viewController = MainViewController(mainViewModel: viewModel)
//        viewController.coordinator = self // Добавим свойство в MainViewController
        navigationController.setViewControllers([viewController], animated: false)
        
        viewModel.onRouteToExit = { [weak self] in
            guard let self = self else { return }
            self.onExit?()
        }
    }
}



