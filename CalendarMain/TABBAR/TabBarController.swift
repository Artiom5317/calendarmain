//
//  TabBarController.swift
//  CalendarMain
//
//  Created by Artiom on 18.01.26.
//

import UIKit


enum Tabs {
    
}


class TabBarController: UITabBarController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTabBar()
    }
    
    
    private func setupTabs() {
        
        let homeVC = MainViewController(mainViewModel: MainViewModel())
        let planVC = PlanViewController(viewModel: PlanViewModel())
        let calendarVC = CalendarViewController(viewModel: CalendarViewModel())
        
        let homeNav = UINavigationController(rootViewController: homeVC)
        let planNav = UINavigationController(rootViewController: planVC)
        let calendarNav = UINavigationController(rootViewController: calendarVC)

        homeNav.tabBarItem = UITabBarItem(
            title: Resources.Strings.TabBar.home,
            image: Resources.Images.TabBar.home,
            tag: 0
        )
        
        planNav.tabBarItem = UITabBarItem(
            title: Resources.Strings.TabBar.plan,
            image: Resources.Images.TabBar.plan,
            tag: 1
            )

        calendarNav.tabBarItem = UITabBarItem(
            title: Resources.Strings.TabBar.calendar,
            image: Resources.Images.TabBar.calendar,
            tag: 2
        )

        viewControllers = [homeNav, planNav, calendarNav]
        self.selectedViewController = homeNav
        
    }
    
    func configureTabBar() {
        self.tabBar.tintColor = Resources.Colors.mainGreenActive
        self.tabBar.unselectedItemTintColor = Resources.Colors.inactive
        self.tabBar.backgroundColor = .systemBackground
        
        tabBar.layer.borderColor = Resources.Colors.separator.cgColor
//        tabBar.layer.borderWidth = 1
        tabBar.layer.masksToBounds = true
        
        
        let topBorder = CALayer()
        topBorder.frame = CGRect(x: 0, y: 0, width: tabBar.frame.width, height: 1)
        topBorder.backgroundColor = Resources.Colors.separator.cgColor
        self.tabBar.layer.addSublayer(topBorder)
        

        // Уберите общий border
//        tabBar.layer.borderWidth = 0
    }
}

#warning("Что такое maskToBound и borderWith если потсавить 10 то что буде")
