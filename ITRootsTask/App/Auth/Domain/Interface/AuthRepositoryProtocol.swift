//
//  AuthRepositoryProtocol.swift
//  ITRootsTask
//
//  Created by Saad Sherif on 19/01/2025.
//


import Combine

protocol AuthRepositoryProtocol {
    
    func login(_ loginCredentials: LoginCredentials) -> AnyPublisher<UserResponse,ResponseError>
    func sendRegister(_ registerModel: RegisterModel) -> AnyPublisher<UserResponse, ResponseError>
}
