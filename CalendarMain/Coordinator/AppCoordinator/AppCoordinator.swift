//
//  AppCoordinator.swift
//  CalendarMain
//
//  Created by Artiom on 18.01.26.
//


import UIKit



protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    func start()
}



final class AppCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }

    func start() {
        // Всегда попадаем сюда (временно)
        showAuthView()
    }
    
    func showMainTabBar() {
        let tabBar = TabBarController()
        let tabBarCoordinator = TabBarCoordinator(tabBar: tabBar)
        childCoordinators.append(tabBarCoordinator)
        tabBarCoordinator.start()
        window.rootViewController = tabBar
        UIView.transition(with: self.window, duration: 0.3, options: .transitionCrossDissolve, animations: nil)
        tabBarCoordinator.logOutCompletion = { [weak self] in
            self?.showAuthView()
        }
    }
    
    
    func showAuthView() {
//        childCoordinators.removeAll()
        let authFlow = AuthCoordinator(window: window)
        
        authFlow.onFinish = { [weak self, weak authFlow] in
            self?.childCoordinators.removeAll{ $0 === authFlow }
            self?.showMainTabBar()
        }
        childCoordinators.append(authFlow)
        authFlow.start()
    }
}
