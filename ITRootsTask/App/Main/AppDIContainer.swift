//
//  AppDIContainer.swift
//  ITRootsTask
//
//  Created by Saad Sherif on 19/01/2025.
//


import UIKit

public class AppDIContainer {
  
    private lazy var apiDataTransferService: NetworkExecuter = {
        return DefaultNetworkExecuter()
    }()
 
    // MARK: - Auth Module -
    
    func buildAuthModule() -> AuthDIContainer {
        let dependencies = AuthDIContainer.Dependencies(
            apiDataTransferService: apiDataTransferService
        )
        return AuthDIContainer(dependencies: dependencies)
    }
    
    // MARK: - Home Module -
    
    func buildHomeModule() -> HomeDIContainer {
        let dependencies = HomeDIContainer.Dependencies(apiDataTransferService: apiDataTransferService)
        return HomeDIContainer(dependencies: dependencies)
    }
    
    // MARK: - Order Module -
    
    func buildMapModule() -> MapDIContainer {
        let dependencies = MapDIContainer.Dependencies(apiDataTransferService: apiDataTransferService)
        return MapDIContainer(dependencies: dependencies)
    }
    // MARK: - Order Module -
    
    func buildUsersModule() -> UsersDIContainer {
        let dependencies = UsersDIContainer.Dependencies(apiDataTransferService: apiDataTransferService)
        return UsersDIContainer(dependencies: dependencies)
    }
}
