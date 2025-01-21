//
//  NetworkServiceProtocol.swift
//  ITRootsTask
//
//  Created by Saad Sherif on 19/01/2025.
//



import Combine

protocol NetworkServiceProtocol {
    func request<ResponseData: Decodable>(_ endPoint: Endpoint<ResponseData>, progress: ((_ progress: Int) -> Void)?
    )-> AnyPublisher<ResponseData, ResponseError>
}

class NetworkService: NetworkServiceProtocol {
 
    private let responseHandler: ResponseHandler
    private let networkExecuter: NetworkExecuter
    
    init(networkExecuter:NetworkExecuter) {
        self.networkExecuter = networkExecuter
        self.responseHandler = DefaultResponseHandler(networkExecuter: networkExecuter)
    }
    
    func request<ResponseData>(_ endPoint: Endpoint<ResponseData>, progress: ((Int) -> Void)?) -> AnyPublisher<ResponseData, ResponseError> where ResponseData : Decodable {
        return  responseHandler.get(endPoint, progress: progress)
    }

    deinit {
        print("NetworkService is deinit, No memory leak found")
    }
}
