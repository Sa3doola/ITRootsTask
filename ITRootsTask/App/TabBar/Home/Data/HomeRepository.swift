//
//  HomeRepository.swift
//  Mesllah
//
//  Created by Saad Sherif on 19/01/2025.
//

import Combine

protocol HomeRepositoryProtocol {
    func createHomeData() -> [HomeEntity]
}

final class HomeRepository: HomeRepositoryProtocol {


    private let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    deinit {
        print("HomeRepository is deinit, No memory leak found")
    }
    
    func createHomeData() -> [HomeEntity] {
        var data = [HomeEntity]()
        data.append(.stores(stores: [.init(), .init(), .init(), .init(), .init(), .init(), .init()]))
        data.append(.productts(products: [.init(), .init(), .init(), .init(), .init(), .init()]))
        return data
    }
}
