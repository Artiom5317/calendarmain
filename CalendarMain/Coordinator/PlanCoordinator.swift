//
//  PlanCoordinator.swift
//  CalendarMain
//
//  Created by Artiom on 25.02.26.
//

import UIKit


// PlanCoordinator.swift
final class PlanCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewModel = PlanViewModel()
        
        
        let viewController = PlanViewController(viewModel: viewModel)
        
        viewModel.onNavigate = { [weak self] route in
            guard let self = self else { return }
            
            switch route {
            case.add:
                goToCreatePlanView()
            case .info:
                let vc = UIViewController()
                vc.view.backgroundColor = Resources.Colors.mainGreenActive
                self.navigationController.topViewController?.present(vc, animated: true)
                
            }
        }
        
        navigationController.setViewControllers([viewController], animated: false)
    }
    
    // Навигационные методы для Plan
    func goToCreatePlanView() {
        let vm = CreatePlanViewModel()
        let vc = CreatePlanViewController(viewModel: vm)
        vc.hidesBottomBarWhenPushed = true
        self.navigationController.pushViewController(vc, animated: true)
    }
}
