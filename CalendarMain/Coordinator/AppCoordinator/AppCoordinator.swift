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
    

    func start() {
        let auth: Bool = true
        
        if auth {
            showMainTabBar()
        }
        else {
            print("fucked up")
        }
    }
    
    
    func showMainTabBar() {
    }
}
