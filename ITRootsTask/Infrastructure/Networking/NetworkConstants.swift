//
//  NetworkConstants.swift
//  ITRootsTask
//
//  Created by Saad Sherif on 19/01/2025.
//


import Foundation

struct NetworkConstants {
    private init() {}
    static let domain = "https://domain.com"
    static var server: String {
        return domain + "/api/"
    }
}
