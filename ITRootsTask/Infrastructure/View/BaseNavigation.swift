//
//  BaseNavigation.swift
//  ITRootsTask
//
//  Created by Saad Sherif on 19/01/2025.
//


import UIKit

class BaseNavigation: UINavigationController {
    
    // MARK: - Properties -
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    // MARK: - Life Cycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.handleAppearance()
    }
    
    // MARK: - Design -
    
    private func handleAppearance() {

        self.view.semanticContentAttribute = Language.isRTL() ? .forceRightToLeft : .forceLeftToRight
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.shadowColor = .clear
        self.navigationBar.standardAppearance = appearance
        self.navigationBar.compactAppearance = appearance
        self.navigationBar.scrollEdgeAppearance = appearance
        self.navigationBar.compactScrollEdgeAppearance = appearance
        self.navigationBar.semanticContentAttribute = Language.isRTL() ? .forceRightToLeft : .forceLeftToRight
    }
    
}
