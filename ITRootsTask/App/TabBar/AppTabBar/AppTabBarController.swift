//
//  AppTabBarController.swift
//  Mesllah
//
//  Created by Saad Sherif on 02/10/2024.
//

import UIKit

class AppTabBarController: UITabBarController {
    
    // MARK: - Life Cycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.initialView()
    }
    
    open override func setViewControllers(_ viewControllers: [UIViewController]?, animated: Bool) {
        super.setViewControllers(viewControllers, animated: animated)
    }
    
    // MARK: - Design -
    
    private func initialView(){
        setupDesign()
    }
  
    private func setupDesign() {
        let tabBarAppearance = UITabBarAppearance()
        let tabBarItemAppearance = UITabBarItemAppearance(style: .inline)
        tabBarAppearance.stackedLayoutAppearance = tabBarItemAppearance
        self.tabBar.tintColor = .systemPurple
        self.tabBar.standardAppearance = tabBarAppearance
        
    }
    
    //MARK: - Deinit -
    
    deinit {
        print("\(Self.self) is deinit, No memory leak found")
    }
}

// MARK: - View Controllers -

extension AppTabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        guard let _ = viewControllers else { return false }
        guard let fromView = selectedViewController?.view, let toView = viewController.view else {
            return false
        }
        
        guard fromView != toView else {
            return false
        }
        
        UIView.transition(from: fromView, to: toView, duration: 0.3, options: [.transitionCrossDissolve], completion: nil)
        return true
    }
}
