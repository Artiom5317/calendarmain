//
//  AuthViewController.swift
//  CalendarMain
//
//  Created by Artiom on 26.02.26.
//

import UIKit


class AuthViewController: UIViewController {
    
    let viewModel: AuthViewModelProtocol
    let signInBtn = PrimaryButton(title: "Go to Main App")
    
    init(viewModel: AuthViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(signInBtn)
        signInBtn.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            signInBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signInBtn.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
        
        signInBtn.addAction(UIAction(handler: { [weak self] _ in
            guard let self = self else { return }
            viewModel.loginButtonTapped()
            
        }), for: .touchUpInside)
        
        setupTopBar()
    }
    
    
    private func setupTopBar() {
        self.navigationItem.title = "AuthView"
    }
    
    deinit {
        print("AuthViewController deinit")
    }
    
}
