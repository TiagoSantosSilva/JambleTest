//
//  ProductListCollectionViewController.swift
//  JambleTest
//
//  Created by Tiago Silva on 21/01/2024.
//

import Combine
import UIKit

final class ProductListCollectionViewController: UICollectionViewController {
    
    enum Section {
        case main
    }
    
    // MARK: - Typealiases
    
    private typealias CellRegistration = UICollectionView.CellRegistration<ProductCell, ProductCellViewModel>
    private typealias DataSource = UICollectionViewDiffableDataSource<Section, ProductCellViewModel>
    private typealias Snapshot = NSDiffableDataSourceSnapshot<Section, ProductCellViewModel>
    
    // MARK: Properties
    
    private let dataSource: DataSource
    
    // MARK: Initialization
    
    init() {
        let layout = ProductListCollectionViewLayoutProxy().layout
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        self.dataSource = DataSource(collectionView: collectionView, cellProvider: Self.cellProvider)
        super.init(collectionViewLayout: layout)
        self.collectionView = collectionView
    }
    
    required init?(coder: NSCoder) {
        nil
    }
    
    // MARK: - Functions

    @MainActor func update(with products: [ProductCellViewModel]) {
        Task {
            var snapshot = Snapshot()
            snapshot.appendSections([Section.main])
            snapshot.appendItems(products, toSection: Section.main)
            collectionView.layer.add(CATransition.fade, forKey: nil)
            await dataSource.apply(snapshot, animatingDifferences: false)
        }
    }
    
    // MARK: - Cell Provider

    private static var cellProvider: ((UICollectionView, IndexPath, ProductCellViewModel) -> UICollectionViewCell?) {
        let cellRegistration = CellRegistration { cell, _, cellViewModel in
            cell.configure(with: cellViewModel)
        }

        return { collectionView, indexPath, cellViewModel in
            collectionView.dequeueConfiguredReusableCell(using: cellRegistration,
                                                         for: indexPath,
                                                         item: cellViewModel)
        }
    }
}

// MARK: - UICollectionViewDelegate

extension ProductListCollectionViewController {
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) else { return }
        cell.bounce()
    }
}
