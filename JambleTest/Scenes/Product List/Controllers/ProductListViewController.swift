//
//  ProductListViewController.swift
//  JambleTest
//
//  Created by Tiago Silva on 14/01/2024.
//

import Combine
import UIKit

final class ProductListViewController: UIViewController {
    
    // MARK: - Private Properties
    
    private let searchBar = ProductListSearchBar(frame: .zero)
    private let toolbar = ProductListToolbar()
    
    private let viewModel: ProductListViewModelProtocol
    private let collectionViewController = ProductListCollectionViewController()
    private let _view: ProductListView
    
    private var cancellables: Set<AnyCancellable> = []
    
    // MARK: Initialization
    
    init(viewModel: ProductListViewModelProtocol) {
        self.viewModel = viewModel
        _view = ProductListView(searchBar: searchBar, toolbar: toolbar)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        nil
    }
    
    // MARK: Life Cycle
    
    override func loadView() {
        view = _view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        _view.setupLayout(collectionView: collectionViewController.collectionView)
        setupStyle()
        setupObservers()
        
        viewModel.loadProducts()
    }
    
    private func addSubviews() {
        add(collectionViewController, to: _view)
    }
    
    private func setupStyle() {
        view.backgroundColor = .systemBackground
    }
    
    private func setupObservers() {
        searchBar.passthroughSubject.sink { [weak self] in
            switch $0 {
            case .reset:
                self?.resetTapped()
            case let .text(text):
                guard let self else { return }
                let products = self.viewModel.filteredProducts(by: .text(text))
                self.updateInterface(with: products)
                self.setupToolbarActions()
            }
        }.store(in: &cancellables)
        
        viewModel.subject.sink { [weak self] in
            switch $0 {
            case let .products(products):
                self?.updateInterface(with: products)
                self?.setupToolbarActions()
            case .error:
                // TODO: Display error screen
                return
            }
        }.store(in: &cancellables)
        
        registerForTraitChanges([UITraitUserInterfaceStyle.self], handler: { (self: Self, previousTraitCollection: UITraitCollection) in
            self._view.updateGradientViewColor()
        })
    }
    
    private func updateInterface(with products: [ProductCellViewModel]) {
        collectionViewController.update(with: products)
        _view.configureItemCountLabel(with: products)
        setupToolbarActions()
    }
    
    private func setupToolbarActions() {
        let sortPriceAscAction = UIAction(title: LocalizedStrings.priceAscending) { _ in
            self.updateInterface(with: self.viewModel.sortedProducts(by: .priceAsc))
        }
        
        let sortPriceDescAction = UIAction(title: LocalizedStrings.priceDescending) { _ in
            self.updateInterface(with: self.viewModel.sortedProducts(by: .priceDesc))
        }
        
        let sortMenu = UIMenu(children: [sortPriceDescAction, sortPriceAscAction])
        
        let filterActions = viewModel.filters.map {
            switch $0 {
            case let .color(option, count):
                return UIAction(title: LocalizedStrings.colorFilter(option, count: count)) { _ in
                    self.updateInterface(with: self.viewModel.filteredProducts(by: .color(option)))
                }
            case let .size(option, count):
                return UIAction(title: LocalizedStrings.sizeFilter(option, count: count)) { _ in
                    self.updateInterface(with: self.viewModel.filteredProducts(by: .size(option)))
                }
            }
        }
        
        let filterMenu = UIMenu(children: filterActions)
        
        toolbar.configureButtonMenus(sort: sortMenu,
                                     sortTitle: viewModel.selectedSortCriteriaTitle,
                                     filter: filterMenu,
                                     filterTitle: viewModel.selectedFilterTitle)
    }
    
    private func resetTapped() {
        searchBar.reset()
        let products = viewModel.resetFilters()
        _view.configureItemCountLabel(with: products)
        collectionViewController.update(with: products)
    }
}
