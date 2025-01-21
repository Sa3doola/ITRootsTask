//
//  AuthRepository.swift
//  ITRootsTask
//
//  Created by Saad Sherif on 19/01/2025.
//


import Combine

final class AuthRepository: AuthRepositoryProtocol {
    
    var networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func login(_ loginCredentials: LoginCredentials) -> AnyPublisher<UserResponse, ResponseError> {
        let endPoint = AuthEndPoints.loginAPIComponent(loginCredentials)
        return networkService.request(endPoint, progress: nil)
    }
    
    func sendRegister(_ registerModel: RegisterModel) -> AnyPublisher<UserResponse, ResponseError> {
        let endPoint = AuthEndPoints.newAccountApiComponent(registerModel)
        return networkService.request(endPoint, progress: nil)
    }
    
    deinit {
        print("AuthRepository is deinit, No memory leak found")
    }
}
