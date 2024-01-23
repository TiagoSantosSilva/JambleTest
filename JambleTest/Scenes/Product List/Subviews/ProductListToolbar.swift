//
//  ProductListToolbar.swift
//  JambleTest
//
//  Created by Tiago Silva on 19/01/2024.
//

import Combine
import UIKit

final class ProductListToolbar: UIView {
    enum ProductListToolbarAction {
        case sort
        case filter
    }
    
    let passthroughSubject = PassthroughSubject<ProductListToolbarAction, Never>()
    private let sortButton = RoundedButton(title: LocalizedStrings.sortBy, image: .menu)
    private let filterButton = RoundedButton(title: LocalizedStrings.filter, image: .filter)
    private let stackView = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        nil
    }
    
    func configureButtonMenus(sort sortMenu: UIMenu,
                              sortTitle: String? = nil,
                              filter filterMenu: UIMenu,
                              filterTitle: String? = nil) {
        sortButton.menu = sortMenu
        sortButton.showsMenuAsPrimaryAction = true
        sortButton.setTitle(sortTitle ?? LocalizedStrings.sortBy, for: .normal)
        
        filterButton.menu = filterMenu
        filterButton.showsMenuAsPrimaryAction = true
        filterButton.setTitle(filterTitle ?? LocalizedStrings.filter, for: .normal)
    }
    
    private func setup() {
        setupStackView()
        setupSortButton()
        setupFilterButton()
    }
    
    private func setupStackView() {
        addSubview(stackView)
        stackView.axis = .horizontal
        stackView.addArrangedSubview(sortButton)
        stackView.addArrangedSubview(filterButton)
        stackView.spacing = Constraints.StackView.spacing
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        stackView.constraint(to: self, anchors: [.vertical])
    }
    
    private func setupSortButton() {
        sortButton.addTarget(self, action: #selector(sortButtonTapped), for: .touchUpInside)
    }
    
    private func setupFilterButton() {
        filterButton.addTarget(self, action: #selector(filterButtonTapped), for: .touchUpInside)
    }
    
    // MARK: Selectors
    
    @objc
    private func sortButtonTapped(_ sender: UIButton) {
        passthroughSubject.send(.sort)
    }
    
    @objc
    private func filterButtonTapped(_ sender: UIButton) {
        passthroughSubject.send(.filter)
    }
}

// MARK: - Constraints

private extension ProductListToolbar {
    enum Constraints {
        enum StackView {
            static let spacing: CGFloat = 16
        }
    }
}
