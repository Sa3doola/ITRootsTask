//
//  MapDIContainer.swift
//  Mesllah
//
//  Created by Saad Sherif on 19/01/2025.
//

import UIKit

class MapDIContainer {
    
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
    
    func buildMapCoordinator(in navigationController: UINavigationController) -> MapCoordinatorProtocol {
        let coordinator = MapCoordinator(navigationController: navigationController, dependencies: self)
        return coordinator
    }
}

// MARK: - HomeCoordinatorDependencies -

extension MapDIContainer: MapCoordinatorDependencies {
    func buildMapViewController(coordinator: MapCoordinatorProtocol) -> MapVC {
        let ViewModel = MapViewModel(coordinator: coordinator)
        return MapVC(viewModel: ViewModel)
    }
}
