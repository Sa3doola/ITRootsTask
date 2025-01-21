//
//  UsersDIContainer.swift
//  Mesllah
//
//  Created by Saad Sherif on 19/01/2025.
//

import UIKit

class UsersDIContainer {
    
    struct Dependencies {
        let apiDataTransferService: NetworkExecuter
    }
    
    let dependencies: Dependencies
    
    // MARK: - Init -
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    // MARK: - Deinit -
    
    deinit {
        print("HomeDIContainer is deinit, No memory leak found")
    }
    
    // MARK: - Module Coordinator -
    
    func buildUserCoordinator(in navigationController: UINavigationController) -> UserCoordinatorProtocol {
        let coordinator = UsersCoordinator(navigationController: navigationController, dependencies: self)
        return coordinator
    }
}

// MARK: - UserCoordinatorDependencies -

extension UsersDIContainer: UserCoordinatorDependencies {
    
    func buildUserViewController(coordinator: UserCoordinatorProtocol) -> UsersVC {
        let ViewModel = UsersViewModel(coordinator: coordinator)
        return UsersVC(viewModel: ViewModel)
    }
}
