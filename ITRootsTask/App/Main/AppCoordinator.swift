//
//  AppCoordinator.swift
//  ITRootsTask
//
//  Created by Saad Sherif on 19/01/2025.
//

import UIKit

fileprivate enum LaunchInstructor {
    case auth, main
        
    static func setup() -> LaunchInstructor {
        switch (Session.isAuthorized) {
        case true:
            return .main
        case false:
            return .auth
        }
    }
}

public class AppCoordinator: Coordinator {
    
    public var onCompletion: CompletionBlock?
    
    private let window: UIWindow
    private let appDIContainer: AppDIContainer
    private var childCoordinators = [Coordinator]()
    
    fileprivate var instructor: LaunchInstructor {
        return LaunchInstructor.setup()
    }
    
    public init(window: UIWindow,
                appDIContainer: AppDIContainer) {
        self.window = window
        self.appDIContainer = appDIContainer
    }
    
    public func start() {
        startSplash()
    }
    
    private func checkRoute() {
        switch instructor {
        case .auth:
            navigateToAuthFlow()
        case .main:
            navigateToTabBarFlow()
        }
    }
    
    fileprivate func startSplash() {
        let splash = SplashVC()
        splash.onCompletion = { [weak self] in
            guard let self else { return }
            checkRoute()
        }
        self.window.rootViewController = splash
        self.window.makeKeyAndVisible()
    }

    fileprivate func navigateToAuthFlow() {
        let navigation = BaseNavigation()
        let module = appDIContainer.buildAuthModule()
        let coordinator = module.buildAuthCoordinator(in: navigation)
        coordinator.onCompletion = { [unowned self, unowned coordinator] in
            removeDependency(coordinator)
            self.checkRoute()
        }
        self.window.rootViewController = navigation
        self.window.makeKeyAndVisible()
        addDependency(coordinator)
        coordinator.start()
    }
    
    fileprivate func navigateToTabBarFlow() {
        let tabBar = AppTabBarController()
        let coordinator = TabBarCoordinator(tabBarController: tabBar,
                                            appDIContainer: appDIContainer)
        coordinator.onCompletion = { [unowned self, unowned coordinator] in
            removeDependency(coordinator)
            self.checkRoute()
        }
        self.window.rootViewController = tabBar
        self.window.makeKeyAndVisible()
        addDependency(coordinator)
        coordinator.start()
    }
}

extension AppCoordinator {
    
    public func removeDependency(_ coordinator: Coordinator?) {
        guard
            childCoordinators.isEmpty == false,
            let coordinator = coordinator
            else { return }
        
        for (index, element) in childCoordinators.enumerated() {
            if element === coordinator {
                childCoordinators.remove(at: index)
                break
            }
        }
    }
    
    public func addDependency(_ coordinator: Coordinator) {
        for element in childCoordinators {
            if element === coordinator { return }
        }
        childCoordinators.append(coordinator)
    }
    
}
