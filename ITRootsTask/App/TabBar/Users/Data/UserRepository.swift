//
//  UserRepository.swift
//  ITRootsTask
//
//  Created by Saad Sherif on 19/01/2025.
//

import Combine

protocol UserRepositoryProtocol {
    func callUserAPI() -> AnyPublisher<UserElementResponse, ResponseError>
}

final class UserRepository: UserRepositoryProtocol {
    
    var networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func callUserAPI() -> AnyPublisher<UserElementResponse, ResponseError> {
        let endPoint = UserEndPoints.usersAPI()
        return networkService.request(endPoint, progress: nil)
    }

}
