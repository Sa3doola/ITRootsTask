//
//  RequestHeaderType.swift
//  ITRootsTask
//
//  Created by Saad Sherif on 19/01/2025.
//



import Foundation

enum RequestHeaderType {
    
    case authorized(token: String)
    case unauthorized
    
    var header: [String:String] {
        
        var commonHeaders = [
            "Accept": "application/json",
            "Content-Type": "application/json",
            "lang": Language.apiLanguage()
        ]
        
        switch self {
        case .authorized(let token):
            commonHeaders["Authorization"] = "Bearer \(token)"
            return commonHeaders
        case .unauthorized:
            return commonHeaders
        }
        
    }
    
}