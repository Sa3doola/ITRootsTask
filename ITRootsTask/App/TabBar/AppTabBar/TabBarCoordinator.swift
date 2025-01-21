//
//  TabBarCoordinator.swift
//  ITRootsTask
//
//  Created by Saad Sherif on 19/01/2025.
//



import UIKit

class TabBarCoordinator: Coordinator {

    var onCompletion: CompletionBlock?
    private let tabBarController: AppTabBarController
    private let appDIContainer: AppDIContainer
    private var childCoordinators = [TabBarChildCoordinator: Coordinator]()
    
    init(tabBarController: AppTabBarController, appDIContainer: AppDIContainer) {
        self.tabBarController = tabBarController
        self.appDIContainer = appDIContainer
    }
    
    func start() {
        showMainTabBar()
    }
    
    fileprivate func showMainTabBar() {
    
        let homeNavigation = createNavigationController(item: .home)
        buildHomeScene(in: homeNavigation)
        
        let mapNavigation = createNavigationController(item: .map)
        buildMapScene(in: mapNavigation)
        
        let usersNavigation = createNavigationController(item: .users)
        buildUserScene(in: usersNavigation)
        
        let vcs = [homeNavigation, mapNavigation, usersNavigation]
        tabBarController.setViewControllers(vcs, animated: true)
    }
    
    fileprivate func buildHomeScene(in navigation: UINavigationController) {
        let module = appDIContainer.buildHomeModule()
        let coordinator = module.buildHomeCoordinator(in: navigation)
        coordinator.onCompletion = onCompletion
        coordinator.start()
        childCoordinators[.home] = coordinator
    }
    
    fileprivate func buildMapScene(in navigation: UINavigationController) {
        let module = appDIContainer.buildMapModule()
        let coordinator = module.buildMapCoordinator(in: navigation)
        coordinator.onCompletion = onCompletion
        coordinator.start()
        childCoordinators[.map] = coordinator
    }
    
    fileprivate func buildUserScene(in navigation: UINavigationController) {
        let module = appDIContainer.buildUsersModule()
        let coordinator = module.buildUserCoordinator(in: navigation)
        coordinator.onCompletion = onCompletion
        coordinator.start()
        childCoordinators[.users] = coordinator
    }
    
}

// MARK: - TabBar Items -

extension TabBarCoordinator {

    fileprivate func createNavigationController(item: TabBarChildCoordinator) -> BaseNavigation {
        let nav = BaseNavigation()
        nav.tabBarItem = tabBarItem(for: item)
        return nav
    }
    
    fileprivate func tabBarItem(for item: TabBarItem) -> UITabBarItem {
        let item = UITabBarItem(
            title: item.title,
            image: .init(systemName: item.image),
            tag: item.tag
        )
        return item
    }
}
