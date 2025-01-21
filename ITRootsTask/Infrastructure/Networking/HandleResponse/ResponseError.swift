//
//  ResponseError.swift
//  ITRootsTask
//
//  Created by Saad Sherif on 19/01/2025.
//


import Foundation

enum ResponseError: Error {
    case canNotConnectToServer
    case serverError
    case unableToDecodeResponse
    case server(message: String)
    case requetGeneration
}

extension ResponseError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .canNotConnectToServer:
            return "Can not send request, please check your connection"
        case .serverError:
            return "There is an error in our servers and we work on it, please try again later"
        case .unableToDecodeResponse:
            return "unexpected error happened and we will work on it, please try again later"
        case .server(let message):
            return message
        case .requetGeneration:
            return ""
        }
    }
}