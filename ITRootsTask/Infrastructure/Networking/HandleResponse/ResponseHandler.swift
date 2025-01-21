//
//  ResponseHandler.swift
//  ITRootsTask
//
//  Created by Saad Sherif on 19/01/2025.
//

import Foundation
import Combine

protocol ResponseHandler {
    func get<T: Decodable>(_ endpoint: Endpoint<T>, progress: ((_ progress: Int) -> Void)?) -> AnyPublisher<T, ResponseError>
}

struct DefaultResponseHandler: ResponseHandler {
    
    private let networkExecuter: NetworkExecuter
    
    init(networkExecuter: NetworkExecuter = DefaultNetworkExecuter()) {
        self.networkExecuter = networkExecuter
    }
    
    func get<T: Decodable>(_ endpoint: Endpoint<T>, progress: ((_ progress: Int) -> Void)? = nil) -> AnyPublisher<T, ResponseError> {
        return networkExecuter
            .execute(endpoint, progress: progress)
            .handleEvents(receiveOutput: { data in
                self.printApiResponse(data, for: endpoint.server + endpoint.path)
            })
            .flatMap { data in
                endpoint.decoder.decode(data: data)
            }
            .mapError { error -> ResponseError in
                switch error {
                case .canNotConnectToServer:
                    return .canNotConnectToServer
                case .serverError:
                    return .serverError
                case .unableToDecodeResponse:
                    return .unableToDecodeResponse
                case .server(let message):
                    return .server(message: message)
                case .requetGeneration:
                    return .requetGeneration
                }
            }
            .eraseToAnyPublisher()
    }
    
    private func printApiResponse(_ responseData: Data, for url: String) {
    #if DEBUG
        // Pretty print the response for debugging purposes
        if let jsonObject = try? JSONSerialization.jsonObject(with: responseData, options: []),
           let prettyData = try? JSONSerialization.data(withJSONObject: jsonObject, options: [.prettyPrinted, .sortedKeys]),
           let jsonString = String(data: prettyData, encoding: .utf8) {
            print("\n\n====================================\n⚡️⚡️ RESPONSE FOR \(url):\n\(jsonString)\n====================================\n\n")
        } else {
            print("\n\n====================================\n⚡️⚡️ RESPONSE FOR \(url):\n\(responseData)\n====================================\n\n")
        }
    #endif
    }
}

