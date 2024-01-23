//
//  ProductListViewModel.swift
//  JambleTest
//
//  Created by Tiago Silva on 21/01/2024.
//

import Combine
import Foundation

enum ProductListViewModelAction {
    case products([ProductCellViewModel])
    case error // A TODO would be to add an associated error type/enum where we could redirect which error was fired to the view and then respond accordingly
}

protocol ProductListViewModelProtocol {
    var filters: [ProductListViewModel.SelectableFilter] { get }
    var products: [ProductCellViewModel] { get }
    var subject: PassthroughSubject<ProductListViewModelAction, Never> { get }
    var selectedFilterTitle: String? { get }
    var selectedSortCriteriaTitle: String? { get }
    func loadProducts()
    func filteredProducts(by filters: ProductListViewModel.Filter...) -> [ProductCellViewModel]
    func resetFilters() -> [ProductCellViewModel]
    func sortedProducts(by sortCriteria: ProductListViewModel.SortCriteria) -> [ProductCellViewModel]
}

final class ProductListViewModel: ProductListViewModelProtocol {
    enum Filter {
        case text(String)
        case size(String)
        case color(String)
        
        func isSameType(as other: Filter) -> Bool {
            switch (self, other) {
            case (.text, .text),
                (.size, .size),
                (.size, .color),
                (.color, .color),
                (.color, .size):
                return true
            default:
                return false
            }
        }
    }
    
    enum SelectableFilter {
        case size(option: String, count: Int)
        case color(option: String, count: Int)
    }
    
    enum SortCriteria {
        case priceAsc
        case priceDesc
    }
    
    let subject: PassthroughSubject<ProductListViewModelAction, Never>
    private(set) var filters: [SelectableFilter] = []
    private(set) var products: [ProductCellViewModel] = []
    
    var selectedFilterTitle: String?
    
    var selectedSortCriteriaTitle: String? {
        guard let selectedSortCriteria else { return nil }
        switch selectedSortCriteria {
        case .priceAsc:
            return LocalizedStrings.priceAscending
        case .priceDesc:
            return LocalizedStrings.priceDescending
        }
    }
    
    private let bundleEngine: BundleEngineProtocol
    private var filteredProducts: [ProductCellViewModel] = []
    private var selectedSortCriteria: SortCriteria?
    private var selectedFilters: [ProductListViewModel.Filter] = []
    
    // MARK: Initialization
    
    init(bundleEngine: BundleEngineProtocol,
         subject: PassthroughSubject<ProductListViewModelAction, Never> = .init()) {
        self.subject = subject
        self.bundleEngine = bundleEngine
    }
    
    // MARK: Internal
    
    func loadProducts() {
        do {
            let products = try bundleEngine.load(content: .products) as [Product]
            let viewModels = products.map { ProductCellViewModel(product: $0) }
            self.products = viewModels
            filteredProducts = viewModels
            parseFilters(from: viewModels)
            subject.send(.products(viewModels))
        } catch {
            subject.send(.error)
        }
    }
    
    func filteredProducts(by filters: ProductListViewModel.Filter...) -> [ProductCellViewModel] {
        let newFilters = updateFilters(current: selectedFilters, inputedFilters: filters)
        let filteredProducts = apply(filters: newFilters, to: products)
        self.selectedFilters = newFilters
        self.filteredProducts = filteredProducts
        
        parseFilters(from: filterProductsBySelectedText(products))
        guard let selectedSortCriteria else { return filteredProducts }
        return sortedProducts(by: selectedSortCriteria)
    }
    
    func resetFilters() -> [ProductCellViewModel] {
        self.selectedSortCriteria = nil
        self.selectedFilters = []
        self.selectedFilterTitle = nil
        return products
    }
    
    func sortedProducts(by sortCriteria: SortCriteria) -> [ProductCellViewModel] {
        self.selectedSortCriteria = sortCriteria
        switch sortCriteria {
        case .priceAsc:
            return filteredProducts.sorted(by: { $0.price < $1.price })
        case .priceDesc:
            return filteredProducts.sorted(by: { $0.price > $1.price })
        }
    }
    
    // MARK: Private Functions
    
    private func apply(filters: [Filter], to products: [ProductCellViewModel]) -> [ProductCellViewModel] {
        return filters.reduce(products) { (filteredProducts, filter) in
            switch filter {
            case let .text(text) where !text.isEmpty:
                return filteredProducts.filter { $0.title.localizedCaseInsensitiveContains(text) }
            case let .size(size):
                let products = filteredProducts.filter { $0.size.lowercased() == size.lowercased() }
                self.selectedFilterTitle = LocalizedStrings.sizeFilter(size, count: products.count)
                return products
            case let .color(color):
                let products = filteredProducts.filter { $0.color.localizedStandardContains(color) }
                self.selectedFilterTitle = LocalizedStrings.colorFilter(color, count: products.count)
                return products
            default:
                // For `.text` filters with an empty string or other filter types, just skip
                return filteredProducts
            }
        }
    }
    
    private func parseFilters(from products: [ProductCellViewModel]) {
        let sizes: [SelectableFilter] = Set(products.map { $0.size }).map { size in
            let count = products.filter { $0.size == size }.count
            return .size(option: size, count: count)
        }
        
        let colors: [SelectableFilter] = Set(products.map { $0.color }).map { color in
            let count = products.filter { $0.color == color }.count
            return .color(option: color, count: count)
        }
        
        self.filters = sizes + colors
    }
    
    private func filterProductsBySelectedText(_ products: [ProductCellViewModel]) -> [ProductCellViewModel] {
        if let textFilter = selectedFilters.first(where: {
            if case let .text(string) = $0 {
                return !string.isEmpty
            } else {
                return false
            }
        }) {
            switch textFilter {
            case let .text(string):
                return products.filter { $0.title.localizedCaseInsensitiveContains(string) }
            default:
                fatalError()
            }
        } else {
            return products
        }
    }
    
    private func updateFilters(current currentFilters: [ProductListViewModel.Filter],
                               inputedFilters: [ProductListViewModel.Filter]) -> [ProductListViewModel.Filter] {
        inputedFilters.reduce(into: currentFilters) { (selectedFilters, newFilter) in
            if let currentFilterIndex = selectedFilters.firstIndex(where: { $0.isSameType(as: newFilter) }) {
                selectedFilters[currentFilterIndex] = newFilter
            } else {
                selectedFilters.append(newFilter)
            }
        }
    }
}
