//
//  ProductListCoordinator.swift
//  JambleTest
//
//  Created by Tiago Silva on 14/01/2024.
//

import UIKit

final class ProductListCoordinator: Coordinator {
    
    var viewController: UIViewController {
        navigator.navigationController
    }
    
    private let dependencies: DependencyContainerProtocol
    private let navigator: Navigatable
    
    init(dependencies: DependencyContainerProtocol) {
        self.dependencies = dependencies
        let viewModel = ProductListViewModel(bundleEngine: dependencies.bundleEngine)
        let viewController = ProductListViewController(viewModel: viewModel)
        let navigationController = UINavigationController(rootViewController: viewController)
        self.navigator = Navigator(navigationController: navigationController)
        navigationController.navigationBar.isHidden = true
    }
    
    func start() {}
}
