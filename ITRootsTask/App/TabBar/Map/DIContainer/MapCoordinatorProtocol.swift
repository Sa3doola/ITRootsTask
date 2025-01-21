//
//  MapCoordinatorProtocol.swift
//  Mesllah
//
//  Created by Saad Sherif on 19/01/2025.
//

import UIKit

protocol MapCoordinatorProtocol: NavigationCoordinator {
    func navigate(to step: MapStep)
}

// MARK: - Coordinator Dependencies
protocol MapCoordinatorDependencies {
    func buildMapViewController(coordinator: MapCoordinatorProtocol) -> MapVC
   
}

// MARK: - Steps -

public enum MapStep: Step {
    case mapInit
}
