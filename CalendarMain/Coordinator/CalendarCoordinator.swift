//
//  CalendarCoordinator.swift
//  CalendarMain
//
//  Created by Artiom on 25.02.26.
//

import UIKit



// CalendarCoordinator.swift
final class CalendarCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewModel = CalendarViewModel()
        let viewController = CalendarViewController(viewModel: viewModel)
        navigationController.setViewControllers([viewController], animated: false)
    }
    
    // Навигационные методы для Calendar
}
