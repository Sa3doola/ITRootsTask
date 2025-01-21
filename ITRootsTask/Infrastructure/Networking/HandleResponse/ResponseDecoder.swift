//
//  ResponseDecoder.swift
//  ITRootsTask
//
//  Created by Saad Sherif on 19/01/2025.
//

import Foundation
import Combine

protocol ResponseDecoder {
    func decode<T: Decodable>(data: Data) -> AnyPublisher<T, ResponseError>
}

// MARK: - DefaultJSONDecoder Struct
struct DefaultJSONDecoder: ResponseDecoder {
    
    // MARK: - Decode Method
    func decode<T: Decodable>(data: Data) -> AnyPublisher<T, ResponseError> {
        Future { promise in
            let decoder = JSONDecoder()
            do {
                let object = try decoder.decode(T.self, from: data)
                if let response = object as? GlobalResponseProtocol {
                    handleGlobalResponse(response, promise: promise, object: object)
                } else {
                    promise(.success(object))
                }
            } catch let decodingError as DecodingError {
                promise(.failure(mapDecodingError(decodingError)))
            } catch {
                promise(.failure(.unableToDecodeResponse))
            }
        }
        .eraseToAnyPublisher()
    }
    
    // MARK: - Handle Global Response
    private func handleGlobalResponse<T: Decodable>(_ response: GlobalResponseProtocol,
                                                    promise: @escaping (Result<T, ResponseError>) -> Void
                                                    ,object: T) {
        switch response.key {
        case .success:
            promise(.success(object))
        case .fail:
            promise(.failure(.server(message: response.message)))
        case .unauthenticated:
            promise(.failure(.server(message: response.message)))
            print("Unauthenticated: \(response.message)")
        case .needActive:
            promise(.success(object))
            print("Need Active: \(response.message)")
        case .exception:
            promise(.failure(.server(message: response.message)))
            print("Exception: \(response.message)")
        case .blocked:
            promise(.failure(.server(message: response.message)))
            print("Blocked: \(response.message)")
        case .needVerification:
            promise(.success(object))
        }
    }
    
    // MARK: - Error Mapping Method
    private func mapDecodingError(_ error: DecodingError) -> ResponseError {
        switch error {
        case .keyNotFound(let key, let context):
            debugPrint("Key '\(key)' not found: \(context.debugDescription)")
            debugPrint("Coding Path: \(context.codingPath)")
        case .valueNotFound(let type, let context):
            debugPrint("Value of type '\(type)' not found: \(context.debugDescription)")
            debugPrint("Coding Path: \(context.codingPath)")
        case .typeMismatch(let type, let context):
            debugPrint("Type mismatch for type '\(type)': \(context.debugDescription)")
            debugPrint("Coding Path: \(context.codingPath)")
        case .dataCorrupted(let context):
            debugPrint("Data corrupted: \(context.debugDescription)")
            debugPrint("Coding Path: \(context.codingPath)")
        @unknown default:
            debugPrint("Unknown decoding error occurred.")
        }
        return .unableToDecodeResponse
    }
}

