//
//  AuthDIContainer.swift
//  Mesllah
//
//  Created by Saad Sherif on 13/10/2024.
//

import UIKit

class AuthDIContainer {
    
    struct Dependencies {
        let apiDataTransferService: NetworkExecuter
    }
    
    private let dependencies: Dependencies
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    deinit {
        print("\(Self.self) is deinit, No memory leak found")
    }
    
    // MARK: - apiDataTransferService -
    
    private lazy var apiDataTransferService: NetworkServiceProtocol = {
        return NetworkService(networkExecuter: dependencies.apiDataTransferService)
    }()
    
    // MARK: - Module Coordinator -
    
    func buildAuthCoordinator(in navigationController: UINavigationController) -> AuthCoordinatorProtocol {
        let coordinator = AuthCoordinator(navigationController: navigationController,
                                          dependencies: self)
        return coordinator
    }
    
    // MARK: - Repository -
    private lazy var authRepository: AuthRepositoryProtocol = {
        return AuthRepository(networkService: apiDataTransferService)
    }()
    
    // MARK: - Use Case -
    
    private func makeLoginUseCase() -> LoginUseCaseProtocol {
        return LoginUseCase(authRepository: authRepository,
                            validator: LoginValidator())
    }
    
    private func makeRegsiterUseCase() -> RegisterUseCaseProtocol {
        return RegisterUseCase(repository: authRepository,
                               validator: RegisterValidator())
    }
}

// MARK: - AuthCoordinatorDependencies -

extension AuthDIContainer: AuthCoordinatorDependencies {
    
    func buildLoginVC(coordinator: AuthCoordinatorProtocol) -> LoginVC {
        let viewModel = LoginViewModel(useCase: makeLoginUseCase(),
                                       coordinator: coordinator)
        return LoginVC(viewModel: viewModel)
    }
    
    func buildRegisterVC(coordinator: AuthCoordinatorProtocol) -> RegisterVC {
        let viewModel = RegisterViewModel(useCase: makeRegsiterUseCase(),
                                            coordinator: coordinator)
        return RegisterVC(viewModel: viewModel)
    }
}
