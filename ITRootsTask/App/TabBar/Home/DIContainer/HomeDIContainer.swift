//
//  HomeDIContainer.swift
//  Mesllah
//
//  Created by Saad Sherif on 19/01/2025.
//

import UIKit

class HomeDIContainer {
    
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
    
    func buildHomeCoordinator(in navigationController: UINavigationController) -> HomeCoordinatorProtocol {
        let coordinator = HomeCoordinator(navigationController: navigationController, dependencies: self)
        return coordinator
    }

    // MARK: - apiDataTransferService -
    
    private lazy var apiDataTransferService: NetworkServiceProtocol = {
        return NetworkService(networkExecuter: dependencies.apiDataTransferService)
    }()
    
    // MARK: - Repository -
    
    private lazy var homeRepository: HomeRepositoryProtocol = {
        return HomeRepository(networkService: apiDataTransferService)
    }()

}

// MARK: - HomeCoordinatorDependencies -

extension HomeDIContainer: HomeCoordinatorDependencies {
    
    func buildHomeViewController(coordinator: HomeCoordinatorProtocol) -> HomeVC {
        let viewModel = HomeViewModel(repository: homeRepository,
                                      coordinator: coordinator)
        return HomeVC(viewModel: viewModel)
    }
}
