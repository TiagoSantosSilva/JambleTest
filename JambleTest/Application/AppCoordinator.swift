//
//  AppCoordinator.swift
//  JambleTest
//
//  Created by Tiago Silva on 14/01/2024.
//

import UIKit

final class AppCoordinator: Coordinator {

    // MARK: - Properties

    private let dependencies: DependencyContainerProtocol
    private let window: UIWindow
    
    // MARK: - Initialization

    init(dependencies: DependencyContainerProtocol, window: UIWindow) {
        self.dependencies = dependencies
        self.window = window
        super.init()
    }

    // MARK: - Coordinator

    func start() {
        let coordinator = ProductListCoordinator(dependencies: dependencies)
        initiate(coordinator: coordinator)
        window.rootViewController = coordinator.viewController
    }
}
