//
//  UserCoordinatorProtocol.swift
//  Mesllah
//
//  Created by Saad Sherif on 19/01/2025.
//

import UIKit

protocol UserCoordinatorProtocol: NavigationCoordinator {
    func navigate(to step: UserStep)
}

// MARK: - Coordinator Dependencies
protocol UserCoordinatorDependencies {
    func buildUserViewController(coordinator: UserCoordinatorProtocol) -> UsersVC
   
}

// MARK: - Steps -

public enum UserStep: Step {
    case userInit
}
