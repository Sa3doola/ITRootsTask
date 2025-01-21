//
//  AuthCoordinatorProtocol.swift
//  Mesllah
//
//  Created by Saad Sherif on 16/10/2024.
//

import UIKit

protocol AuthCoordinatorProtocol: NavigationCoordinator {
    func navigate(to step: AuthStep)
}

// MARK: - Coordinator Dependencies

protocol AuthCoordinatorDependencies {
    func buildLoginVC(coordinator: AuthCoordinatorProtocol) -> LoginVC
    func buildRegisterVC(coordinator: AuthCoordinatorProtocol) -> RegisterVC
}

enum AuthStep: Step {
    case authInit
    case goToRegister
    case goToHome
}

