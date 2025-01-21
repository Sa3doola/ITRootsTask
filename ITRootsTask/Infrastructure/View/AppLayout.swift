//
//  AppLayout.swift
//  ITRootsTask
//
//  Created by Saad Sherif on 19/01/2025.
//

import UIKit

struct AppLayout {
    
    static let shared = AppLayout()
    
    func createHomeLayoutSections(model: [HomeEntity], index: Int) -> NSCollectionLayoutSection {
        switch model[index] {
        
        case .stores:
            return self.favouriteSectionLayout()
        case .productts:
            return self.productLayout()
        }
    }
    
    func favouriteSectionLayout() -> NSCollectionLayoutSection {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(76),
                                              heightDimension: .absolute(76))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 4, bottom: 4, trailing: 4)
        let groupSize = NSCollectionLayoutSize(widthDimension: .estimated(76),
                                               heightDimension: .absolute(76))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 0, leading: 8, bottom: 0, trailing: 0)
        section.orthogonalScrollingBehavior = .continuous
        return section
    }
    
    func productLayout() -> NSCollectionLayoutSection {
    
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5),
                                              heightDimension: .fractionalWidth(0.5))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .estimated(.greatestFiniteMagnitude))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
}
