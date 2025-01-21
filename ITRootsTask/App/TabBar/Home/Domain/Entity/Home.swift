//
//  Home.swift
//  ITRootsTask
//
//  Created by Saad Sherif on 19/01/2025.
//

enum HomeEntity {
    case stores(stores: [Store])
    case productts(products: [Product])
}

extension HomeEntity {
    
    var numberOfItems: Int {
        switch self {
        case .stores(let stores):
            return stores.count
        case .productts(let products):
            return products.count
        }
    }
}
