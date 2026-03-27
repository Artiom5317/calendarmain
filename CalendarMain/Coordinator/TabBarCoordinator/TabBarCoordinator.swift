//
//  TabBarCoordinator.swift
//  CalendarMain
//
//  Created by Artiom on 25.02.26.
//

import UIKit

protocol TabBarCoordinatorProtocol: AnyObject {
    func logOut()
}


class TabBarCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var logOutCompletion: (() -> Void)?
    var tabBarController: TabBarController // <- твой кастомный класс
    
    init(tabBar: TabBarController) {
        self.tabBarController = tabBar
    }

    func start() {
        let homeNav = UINavigationController()
        let planNav = UINavigationController()
        let calendarNav = UINavigationController()

        // tabBarItem настраиваем здесь, в одном месте
        homeNav.tabBarItem = UITabBarItem(title: Resources.Strings.TabBar.home, image: Resources.Images.TabBar.home, tag: 0)
        planNav.tabBarItem = UITabBarItem(title: Resources.Strings.TabBar.plan, image: Resources.Images.TabBar.plan, tag: 1)
        calendarNav.tabBarItem = UITabBarItem(title: Resources.Strings.TabBar.calendar, image: Resources.Images.TabBar.calendar, tag: 2)

        let homeCoord = HomeCoordinator(navigationController: homeNav)
        let planCoord = PlanCoordinator(navigationController: planNav)
        let calendarCoord = CalendarCoordinator(navigationController: calendarNav)
        
        homeCoord.onExit = { [weak self] in
            guard let self = self else { return }
            self.logOutCompletion?()
        }

        childCoordinators = [homeCoord, planCoord, calendarCoord]

        homeCoord.start()
        planCoord.start()
        calendarCoord.start()

        tabBarController.viewControllers = [homeNav, planNav, calendarNav]
        tabBarController.selectedViewController = homeNav
    }
    
    func logOut() {
        logOutCompletion?()
    }
}
