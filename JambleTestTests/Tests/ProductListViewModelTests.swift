//
//  ProductListViewModelTests.swift
//  JambleTestTests
//
//  Created by Tiago Silva on 22/01/2024.
//

import Combine
@testable import JambleTest
import XCTest

final class ProductListViewModelTests: XCTestCase {
    
    // MARK: Properties
    
    private var cancellables: Set<AnyCancellable>!
    private var subject: PassthroughSubject<ProductListViewModelAction, Never>!
    private var mockBundleEngine: MockBundleEngine!
    private var viewModel: ProductListViewModel!
    
    // MARK: Set Up & Tear Down
    
    override func setUp() {
        super.setUp()
        cancellables = []
        subject = PassthroughSubject<ProductListViewModelAction, Never>()
        mockBundleEngine = MockBundleEngine()
        mockBundleEngine.loadHandler = {
            Product.stub
        }
        viewModel = ProductListViewModel(bundleEngine: mockBundleEngine, subject: subject)
    }
    
    override func tearDown() {
        cancellables = nil
        subject = nil
        mockBundleEngine = nil
        viewModel = nil
        super.tearDown()
    }
    
    // MARK: Tests
    
    func testLoadForSuccessResponse() {
        let expectation = expectation(description: "Successful response received")
        
        subject.sink { result in
            switch result {
            case .products:
                // TODO: To be complete, the test should check that the values that are received
                // are the same as the ones that are expected (case let .products(viewModels) equals
                // to Products.stub
                expectation.fulfill()
            case .error:
                return
            }
        }.store(in: &cancellables)
        
        viewModel.loadProducts()
        
        wait(for: [expectation], timeout: 0.5)
    }
    
    // TODO:
    func testLoadforFailureResponse() {
        
    }
    
    func testReset() {
        // Before
        _ = viewModel.sortedProducts(by: .priceAsc)
        _ = viewModel.filteredProducts(by: .size("M"))
        
        XCTAssertEqual(viewModel.selectedSortCriteriaTitle, "Price Asc")
        XCTAssertEqual(viewModel.selectedFilterTitle, "Size: M (0)")
        
        // When
        _ = viewModel.resetFilters()
        
        // Then
        XCTAssertEqual(viewModel.selectedSortCriteriaTitle, nil)
        XCTAssertEqual(viewModel.selectedFilterTitle, nil)
    }
}
