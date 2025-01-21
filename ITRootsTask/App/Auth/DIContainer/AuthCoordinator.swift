//
//  AuthCoordinator.swift
//  Mesllah
//
//  Created by Saad Sherif on 16/10/2024.
//

import UIKit

class AuthCoordinator: AuthCoordinatorProtocol {
    
    var onCompletion: CompletionBlock?
    
    var navigationController: UINavigationController
    private let dependencies: AuthCoordinatorDependencies
    private var childCoordinators = [Coordinator]()
    
    init(navigationController: UINavigationController,
         dependencies: AuthCoordinatorDependencies) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }
    
    deinit {
        print("\(Self.self) is deinit, No memory leak found")
    }
    
    func start() {
        navigate(to: .authInit)
    }
    
    func removeDependency(_ coordinator: (Coordinator)?) {
        guard
            childCoordinators.isEmpty == false,
            let coordinator = coordinator
            else { return }
        
        for (index, element) in childCoordinators.enumerated() {
            if element === coordinator {
                childCoordinators.remove(at: index)
                break
            }
        }
    }
    
    func addDependency(_ coordinator: Coordinator) {
        for element in childCoordinators {
            if element === coordinator { return }
        }
        childCoordinators.append(coordinator)
    }
}

extension AuthCoordinator {
   
    func navigate(to step: AuthStep) {
        switch step {
        case .authInit:
            navigateToLogin()
        case .goToRegister:
            navigateToRegister()
        case .goToHome:
            onCompletion?()
        }
    }
}

extension AuthCoordinator {
    
    fileprivate func navigateToLogin() {
        let controller = dependencies.buildLoginVC(coordinator: self)
        navigationController.pushViewController(controller, animated: true)
    }
    
    fileprivate func navigateToRegister() {
        let controller = dependencies.buildRegisterVC(coordinator: self)
        navigationController.pushViewController(controller, animated: true)
    }
}
