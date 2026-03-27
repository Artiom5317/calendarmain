//
//  AuthCoordinator.swift
//  CalendarMain
//
//  Created by Artiom on 26.02.26.
//



import UIKit


protocol AuthNavigation: AnyObject {
    func didAuthorize()
}


class AuthCoordinator: Coordinator, AuthNavigation {
    var childCoordinators: [Coordinator] = []
    var onFinish: (() -> Void)?
    var window: UIWindow
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let vm = AuthViewModel()

        vm.navigation = self
        let vc = AuthViewController(viewModel: vm)
        window.rootViewController = vc

    }
    
    func didAuthorize() {
        onFinish?()
    }
    
}
