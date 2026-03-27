//
//  AuthViewModel.swift
//  CalendarMain
//
//  Created by Artiom on 26.02.26.
//

import Foundation




protocol AuthViewModelProtocol: AnyObject {
    func loginButtonTapped()
}


class AuthViewModel: AuthViewModelProtocol {
    weak var navigation: AuthNavigation?
    
    
    func loginButtonTapped() {
        print("ok")
        navigation?.didAuthorize()
    }
    
    deinit {
        print("AuthViewModel deinit")
    }
}
