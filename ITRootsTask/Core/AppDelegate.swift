//
//  AppDelegate.swift
//  ITRootsTask
//
//  Created by Saad Sherif on 19/01/2025.
//

import UIKit
import IQKeyboardManagerSwift
import IQKeyboardToolbarManager

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        Bundle.swizzleLocalization()
        handleKeyboard()
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    }
}

extension AppDelegate {
    
    private func handleKeyboard() {
        IQKeyboardManager.shared.isEnabled = true
        IQKeyboardToolbarManager.shared.isEnabled = true
        IQKeyboardToolbarManager.shared.toolbarConfiguration.tintColor = .black
        IQKeyboardToolbarManager.shared.toolbarConfiguration.doneBarButtonConfiguration = .init(title: "Done".localized)
        
        let disableDistanceOnly: [UIViewController.Type] = []
        
        let disabledVCDistanceAndToolbar: [UIViewController.Type] = []
        
        IQKeyboardManager.shared.disabledDistanceHandlingClasses = disableDistanceOnly
        IQKeyboardToolbarManager.shared.disabledToolbarClasses = disabledVCDistanceAndToolbar
    }
    
}

