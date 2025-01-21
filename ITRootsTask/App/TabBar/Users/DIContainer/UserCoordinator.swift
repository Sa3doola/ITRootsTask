//
//  UsersCoordinator.swift
//  Mesllah
//
//  Created by Saad Sherif on 19/01/2025.
//


import UIKit

class UsersCoordinator: UserCoordinatorProtocol {

    var onCompletion: CompletionBlock?
    var navigationController: UINavigationController
    private let dependencies: UserCoordinatorDependencies
    
    // MARK: - Life Cycle -
    
    init(navigationController: UINavigationController,
         dependencies: UserCoordinatorDependencies) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }
    
    deinit {
        print("deinit \(Self.self)")
    }
    
    // MARK: - Navigation
    
    func start() {
        navigate(to: .userInit)
    }
    
    func navigate(to step: UserStep) {
        switch step {
        case .userInit:
            navigateToUsers()
        }
    }
}

extension UsersCoordinator {
    
    fileprivate func navigateToUsers() {
        let controller = dependencies.buildUserViewController(coordinator: self)
        navigationController.pushViewController(controller, animated: true)
    }
}
