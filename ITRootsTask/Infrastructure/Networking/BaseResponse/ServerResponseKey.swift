//
//  ServerResponseKey.swift
//  ITRootsTask
//
//  Created by Saad Sherif on 19/01/2025.
//



import Foundation

enum ServerResponseKey: String, Decodable {
    case success
    case fail
    case unauthenticated
    case needActive 
    case exception
    case blocked
    case needVerification
    
}

