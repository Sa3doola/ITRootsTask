//
//  HomeCoordinator.swift
//  Mesllah
//
//  Created by Saad Sherif on 19/01/2025.
//


import UIKit

class HomeCoordinator: HomeCoordinatorProtocol {

    var onCompletion: CompletionBlock?
    var navigationController: UINavigationController
    private let dependencies: HomeCoordinatorDependencies
    
    // MARK: - Life Cycle -
    
    init(navigationController: UINavigationController, dependencies: HomeCoordinatorDependencies) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }
    
    deinit {
        print("deinit \(Self.self)")
    }
    
    // MARK: - Navigation
    
    func start() {
        navigate(to: .homeInit)
    }
    
    func navigate(to step: HomeStep) {
        switch step {
        case .homeInit:
            navigateToHome()
        }
    }
}

extension HomeCoordinator {
    
    fileprivate func navigateToHome() {
        let controller = dependencies.buildHomeViewController(coordinator: self)
        navigationController.pushViewController(controller, animated: true)
    }
}
