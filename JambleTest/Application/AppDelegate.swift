//
//  AppDelegate.swift
//  JambleTest
//
//  Created by Tiago Silva on 14/01/2024.
//

import UIKit

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {

    // MARK: - Properties

    lazy var window: UIWindow? = UIWindow(frame: UIScreen.main.bounds)
    
    private lazy var coordinator: AppCoordinator = {
        guard let window = window else { fatalError() }
        let dependencies = DependencyContainer()
        return AppCoordinator(dependencies: dependencies, window: window)
    }()
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window?.makeKeyAndVisible()
        coordinator.start()
        return true
    }
}
