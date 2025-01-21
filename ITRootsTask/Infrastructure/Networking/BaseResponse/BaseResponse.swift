//
//  GlobalResponseProtocol.swift
//  ITRootsTask
//
//  Created by Saad Sherif on 19/01/2025.
//


import Foundation

protocol GlobalResponseProtocol: Decodable {
    var key: ServerResponseKey { get }
    var message: String { get }
}

// MARK: - GlobalResponse -

struct GlobalResponse: GlobalResponseProtocol {
    
    var key: ServerResponseKey
    var message: String
    
    enum CodingKeys: String, CodingKey {
        case key
        case message
    }
}

// MARK: - BaseResponse -

struct BaseResponse<T: Decodable>: GlobalResponseProtocol {
    var key: ServerResponseKey
    var message: String
    var data: T?
    
    enum CodingKeys: String, CodingKey {
        case key
        case message
        case data
    }
}

// MARK: - Pagination -

struct Pagination: Codable {
    var totalItems, countItems, perPage, totalPages: Int?
    var currentPage: Int?
    var nextPageURL, pervPageURL: String?
    
    var isLastPage: Bool {
        guard let totalPages, let currentPage else { return false }
        return totalPages == currentPage
    }

    enum CodingKeys: String, CodingKey {
        case totalItems = "total_items"
        case countItems = "count_items"
        case perPage = "per_page"
        case totalPages = "total_pages"
        case currentPage = "current_page"
        case nextPageURL = "next_page_url"
        case pervPageURL = "perv_page_url"
    }
}
