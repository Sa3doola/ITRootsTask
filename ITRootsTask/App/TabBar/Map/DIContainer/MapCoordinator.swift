//
//  MapCoordinator.swift
//  Mesllah
//
//  Created by Saad Sherif on 19/01/2025.
//


import UIKit

class MapCoordinator: MapCoordinatorProtocol {

    var onCompletion: CompletionBlock?
    var navigationController: UINavigationController
    private let dependencies: MapCoordinatorDependencies
    
    // MARK: - Life Cycle -
    
    init(navigationController: UINavigationController,
         dependencies: MapCoordinatorDependencies) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }
    
    deinit {
        print("deinit \(Self.self)")
    }
    
    // MARK: - Navigation
    
    func start() {
        navigate(to: .mapInit)
    }
    
    func navigate(to step: MapStep) {
        switch step {
        case .mapInit:
            navigateToHome()
        }
    }
}

extension MapCoordinator {
    
    fileprivate func navigateToHome() {
        let controller = dependencies.buildMapViewController(coordinator: self)
        navigationController.pushViewController(controller, animated: true)
    }
}
