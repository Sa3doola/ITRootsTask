//
//  Coordinator.swift
//  ITRootsTask
//
//  Created by Saad Sherif on 19/01/2025.
//

import UIKit

public typealias CompletionBlock = (()       -> Void)

public protocol Coordinator: AnyObject {
    func start()
    func start(with step: Step)
    var onCompletion: CompletionBlock? { get set }
    func removeDependency(_ coordinator: Coordinator?)
    func addDependency(_ coordinator: Coordinator)
}

public extension Coordinator {
    func start() { }
    func start(with step: Step = DefaultStep() ) { }
    func removeDependency(_ coordinator: Coordinator?) {}
    func addDependency(_ coordinator: Coordinator) {}
}

public protocol NavigationCoordinator: Coordinator {
    var navigationController: UINavigationController { get }
}

// MARK: - Step Protocol
/// Describe un posible estado de navegación dentro de un Coordinator
public protocol Step { }

public struct DefaultStep: Step {
    public init() { }
}


