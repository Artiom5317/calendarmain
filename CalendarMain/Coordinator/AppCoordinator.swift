//
//  AppCoordinator.swift
//  CalendarMain
//
//  Created by Artiom on 18.01.26.
//


import UIKit



protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    func start()
}


final class AppCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController = UINavigationController()) {
        self.navigationController = navigationController
    }
    
    func start() {
        showMainTabBar()
    }
    
    
    func showMainTabBar() {
        
    }
}
