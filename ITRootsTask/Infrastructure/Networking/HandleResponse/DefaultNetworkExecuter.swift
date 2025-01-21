//
//  DefaultNetworkExecuter.swift
//  ITRootsTask
//
//  Created by Saad Sherif on 19/01/2025.
//


import Foundation
import Alamofire
import Combine

struct DefaultNetworkExecuter: NetworkExecuter {
    
    func execute(_ request: any Requestable, progress progressHandler: ((_ progress: Int)-> Void)? = nil) -> AnyPublisher<Data, ResponseError> {
        
        // If there are uploads, execute the upload method
        if let uploads = request.uploads, !uploads.isEmpty {
            return Future<Data, ResponseError> { promise in
                Task {
                    do {
                        let data = try await self.upload(request, progress: progressHandler)
                        promise(.success(data))
                    } catch {
                        promise(.failure(.canNotConnectToServer))
                    }
                }
            }
            .eraseToAnyPublisher()
        }
        
        // Otherwise, execute the send method
        return Future<Data, ResponseError> { promise in
            Task {
                do {
                    let data = try await self.send(request)
                    promise(.success(data))
                } catch {
                    promise(.failure(.canNotConnectToServer))
                }
            }
        }
        .eraseToAnyPublisher()
    }
    
    // MARK: - Private Helper Methods
    
    /// Sends a network request using Alamofire and returns the response data asynchronously
    private func send(_ request: any Requestable) async throws -> Data {
        let result = await AF.request(request).serializingData().result
        return try self.handle(result)
    }
    
    /// Handles file uploads using multipart form data and tracks the upload progress
    private func upload(_ request: any Requestable, progress progressHandler: ((_ progress: Int) -> Void)?) async throws -> Data {
        var urlRequest = try request.asURLRequest()
        urlRequest.httpBody = nil
        
        // Perform the upload with Alamofire
        let result = await AF.upload(multipartFormData: { multipartFormData in
            // Add request body parameters as multipart form data
            if let parameters = request.body?.compactMapValues({ $0 }) {
                for (key, value) in parameters {
                    if let array = value as? [Any],
                              let jsonData = try? JSONSerialization.data(withJSONObject: array, options: []) {
                        multipartFormData.append(jsonData, withName: key)
                    } else {
                        // Handle other types (e.g., numbers) as strings
                        multipartFormData.append("\(value)".data(using: .utf8)!, withName: key)
                    }
                }
            }
            // Add the files for upload
            for item in request.uploads ?? [] {
                multipartFormData.append(item.data, withName: item.key, fileName: item.filenameWithExtension, mimeType: item.mimeType.rawValue)
            }
        }, with: urlRequest)
        .uploadProgress(queue: .main) { progress in
            let value = Int(progress.fractionCompleted * 100)
            progressHandler?(value)
            print("Upload Progress: \(value)%")
        }
        .serializingData().result
        
        // Handle the result and return data
        return try self.handle(result)
    }
    
    /// Handles the result of a network request, throwing errors if necessary
    private func handle(_ result: Result<Data, AFError>) throws -> Data {
        switch result {
        case .success(let data):
            return data
        case .failure(let error):
            throw error
        }
    }
}