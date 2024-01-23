//
//  ProductListCollectionViewLayout.swift
//  JambleTest
//
//  Created by Tiago Silva on 21/01/2024.
//

import UIKit

final class ProductListCollectionViewLayoutProxy {
    
    lazy var layout: UICollectionViewCompositionalLayout = {
        UICollectionViewCompositionalLayout { section, _ in
            self.layout(at: section)
        }
    }()
    
    private func layout(at section: Int) -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: Layout.Item.width,
                                              heightDimension: Layout.Item.height)
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(withEqualValue: Layout.Item.contentInset)

        let groupSize = NSCollectionLayoutSize(widthDimension: Layout.Group.width,
                                               heightDimension: Layout.Group.height)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                       subitems: [item])

        let layoutSection = NSCollectionLayoutSection(group: group)
        layoutSection.contentInsets = NSDirectionalEdgeInsets(withEqualValue: Layout.Section.contentInset)
        return layoutSection
    }
}

// MARK: - Constants

private extension ProductListCollectionViewLayoutProxy {
    enum Layout {
        enum Item {
            static let width: NSCollectionLayoutDimension = .fractionalWidth(0.5)
            static let height: NSCollectionLayoutDimension = .fractionalWidth(0.8)
            static let contentInset: CGFloat = 4
        }

        enum Group {
            static let width: NSCollectionLayoutDimension = .fractionalWidth(1.0)
            static let height: NSCollectionLayoutDimension = .fractionalWidth(0.8)
        }

        enum Section {
            static let contentInset: CGFloat = 8
        }
    }
}
