//
//  ProductListView.swift
//  JambleTest
//
//  Created by Tiago Silva on 22/01/2024.
//

import UIKit

final class ProductListView: UIView {
    
    // MARK: Properties
    
    private var hasSetupGradientView: Bool = false
    
    // MARK: Subviews
    
    private let divider = Divider()
    private let itemCountLabel = UILabel()
    private let gradientView = GradientView()
    private let toolbar: ProductListToolbar
    private let searchBar: ProductListSearchBar
    
    // MARK: Initialization
    
    init(searchBar: ProductListSearchBar, toolbar: ProductListToolbar) {
        self.searchBar = searchBar
        self.toolbar = toolbar
        super.init(frame: .zero)
        backgroundColor = .systemOrange
    }
    
    required init?(coder: NSCoder) {
        nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupGradientView()
    }
    
    func setupLayout(collectionView: UICollectionView) {
        add(children: searchBar, divider, itemCountLabel, gradientView, toolbar)
        
        setupSearchBar()
        setupDivider()
        setupItemCountLabel()
        setupCollectionView(collectionView)
        setupToolbar()
    }
    
    func configureItemCountLabel(with products: [ProductCellViewModel]) {
        itemCountLabel.text = LocalizedStrings.resultItemCount(products.count)
    }
    
    func updateGradientViewColor() {
        gradientView.setupColor(.systemBackground)
    }
    
    private func setupSearchBar() {
        searchBar.constraint(to: safeAreaLayoutGuide,
                             anchors: [.top, .horizontal],
                             padding: Constants.SearchBar.padding)
        searchBar.frame(height: Constants.SearchBar.height)
    }
    
    private func setupDivider() {
        divider.frame(height: Constants.Divider.height)
        divider.topAnchor.constraint(equalTo: searchBar.bottomAnchor,
                                     constant: Constants.Divider.padding).isActive = true
        divider.constraint(to: safeAreaLayoutGuide,
                           anchors: [.horizontal],
                           padding: Constants.Divider.padding)
    }
    
    private func setupItemCountLabel() {
        itemCountLabel.constraint(to: safeAreaLayoutGuide,
                                  anchors: [.horizontal],
                                  padding: Constants.ItemCountLabel.horizontalPadding)
        itemCountLabel.topAnchor.constraint(equalTo: divider.bottomAnchor,
                                            constant: Constants.ItemCountLabel.verticalPadding).isActive = true
        itemCountLabel.font = Constants.ItemCountLabel.font
        itemCountLabel.textColor = .secondaryLabel
    }
    
    private func setupCollectionView(_ collectionView: UICollectionView) {
        collectionView.constraint(to: self, anchors: [.horizontal, .bottom])
        collectionView.topAnchor.constraint(equalTo: itemCountLabel.bottomAnchor,
                                            constant: Constants.CollectionView.padding).isActive = true
        collectionView.contentInset = Constants.CollectionView.contentInset
    }
    
    private func setupToolbar() {
        toolbar.constraint(to: safeAreaLayoutGuide,
                           anchors: [.bottom, .horizontal],
                           padding: Constants.Toolbar.padding)
        toolbar.frame(height: Constants.Toolbar.height)
    }
    
    private func setupGradientView() {
        gradientView.constraint(to: self, anchors: [.horizontal, .bottom])
        gradientView.topAnchor.constraint(equalTo: toolbar.topAnchor).isActive = true
        if gradientView.bounds.width > 0, !hasSetupGradientView {
            gradientView.constraint(to: gradientView.bounds)
            hasSetupGradientView = true
        }
        
        gradientView.setupColor(.systemBackground)
    }
}

// MARK: - Constants

private extension ProductListView {
    enum Constants {
        enum SearchBar {
            static let height: CGFloat = 48
            static let padding: CGFloat = 16
        }
        
        enum Divider {
            static let height: CGFloat = 1
            static let padding: CGFloat = 16
        }
        
        enum ItemCountLabel {
            static let font: UIFont = .systemFont(ofSize: 14, weight: .regular)
            static let verticalPadding: CGFloat = 16
            static let horizontalPadding: CGFloat = 20
        }
        
        enum Toolbar {
            static let height: CGFloat = 52
            static let padding: CGFloat = 16
        }
        
        enum CollectionView {
            static let padding: CGFloat = 8
            static let contentInset: UIEdgeInsets = .init(top: 0,
                                                          left: 0,
                                                          bottom: Constants.Toolbar.height + 40,
                                                          right: 0)
        }
    }
}
