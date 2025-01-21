//
//  TabBarItem.swift
//  ITRootsTask
//
//  Created by Saad Sherif on 19/01/2025.
//


protocol TabBarItem {
    var title: String { get }
    var image: String { get }
    var tag: Int { get }
}

enum TabBarChildCoordinator: Int, CaseIterable {
    case home
    case map
    case users
}

extension TabBarChildCoordinator: TabBarItem {
    
    var image: String {
        switch self {
        case .home:
            return "house.fill"
        case .map:
            return "map.fill"
        case .users:
            return "person.fill"
        }
    }
    
    var title: String {
        switch self {
        case .home:
            return "Home_tabBar_title".localized
        case .map:
            return "Map_tabBar_title".localized
        case .users:
            return "Users_tabBar_title".localized
        }
    }
    
    var tag: Int { return rawValue }
}

