//
//  ProductCell.swift
//  JambleTest
//
//  Created by Tiago Silva on 21/01/2024.
//

import Combine
import Kingfisher
import UIKit

final class ProductCell: UICollectionViewCell {
    
    // MARK: Properties
    
    private var cancellables: Set<AnyCancellable> = []
    
    // MARK: Subviews
    
    private let imageView: UIImageView = .init()
    private let priceLabel: UILabel = .init()
    private let nameLabel: UILabel = .init()
    private let sizeLabel: UILabel = .init()
    private var bookMarkButton: BookmarkButton = .init()
    private var viewModel: ProductCellViewModel?
    
    // MARK: Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        nil
    }
    
    // MARK: Life Cycle
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        imageView.backgroundColor = nil
        priceLabel.text = nil
        nameLabel.text = nil
        sizeLabel.text = nil
        bookMarkButton.isHidden = true
        viewModel = nil
    }
    
    // MARK: Functions
    
    func configure(with viewModel: ProductCellViewModel) {
        priceLabel.text = viewModel.priceText
        nameLabel.text = viewModel.title
        sizeLabel.text = viewModel.size
        imageView.backgroundColor = UIColor(hex: viewModel.color)
        imageView.kf.setImage(with: viewModel.image)
        bookMarkButton.isHidden = false
        bookMarkButton.configure(isBookmarked: viewModel.isBookmarked,
                                 bookmarkCount: viewModel.bookmarkCount)
        self.viewModel = viewModel
    }
    
    // MARK: Setups
    
    private func setup() {
        contentView.add(children: imageView, priceLabel, nameLabel, sizeLabel, bookMarkButton)
        setupImageView()
        setupPriceLabel()
        setupNameLabel()
        setupSizeLabel()
        setupBookmarkButton()
        setupObservers()
    }
    
    private func setupImageView() {
        imageView.constraint(to: contentView, anchors: [.top, .horizontal])
        imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor,
                                          multiplier: Constants.ImageView.heightMultiplier).isActive = true
    }
    
    private func setupPriceLabel() {
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor,
                                        constant: Constants.PriceLabel.padding).isActive = true
        priceLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor,
                                            constant: Constants.PriceLabel.padding).isActive = true
        priceLabel.trailingAnchor.constraint(lessThanOrEqualTo: imageView.trailingAnchor,
                                             constant: -Constants.PriceLabel.padding).isActive = true
        priceLabel.font = Constants.PriceLabel.font
        priceLabel.textColor = .label
    }
    
    private func setupNameLabel() {
        nameLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor,
                                       constant: Constants.NameLabel.padding).isActive = true
        nameLabel.constraint(to: priceLabel, anchors: [.horizontal])
        nameLabel.font = Constants.NameLabel.font
        nameLabel.textColor = .secondaryLabel
    }
    
    private func setupSizeLabel() {
        sizeLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor,
                                       constant: Constants.SizeLabel
            .padding).isActive = true
        sizeLabel.constraint(to: priceLabel, anchors: [.horizontal])
        sizeLabel.font = Constants.SizeLabel.font
        sizeLabel.textColor = .secondaryLabel
    }
    
    private func setupBookmarkButton() {
        bookMarkButton.translatesAutoresizingMaskIntoConstraints = false
        bookMarkButton.bottomAnchor.constraint(equalTo: imageView.bottomAnchor,
                                               constant: -Constants.BookmarkButton.padding).isActive = true
        bookMarkButton.trailingAnchor.constraint(equalTo: imageView.trailingAnchor,
                                                 constant: -Constants.BookmarkButton.padding).isActive = true
    }
    
    private func setupObservers() {
        bookMarkButton.touchSubject.sink { [weak self] in
            guard let viewModel = self?.viewModel else { return }
            viewModel.toggleBookmark()
            self?.fade {
                self?.bookMarkButton.configure(isBookmarked: viewModel.isBookmarked,
                                               bookmarkCount: viewModel.bookmarkCount)
            }
        }.store(in: &cancellables)
    }
}

// MARK: - Constants

private extension ProductCell {
    enum Constants {
        enum ImageView {
            static let heightMultiplier: CGFloat = 1.2
        }
        
        enum PriceLabel {
            static let font: UIFont = .systemFont(ofSize: 14, weight: .bold)
            static let padding: CGFloat = 8
        }
        
        enum NameLabel {
            static let font: UIFont = .systemFont(ofSize: 12, weight: .regular)
            static let padding: CGFloat = 8
        }
        
        enum SizeLabel {
            static let font: UIFont = .systemFont(ofSize: 12, weight: .regular)
            static let padding: CGFloat = 8
        }
        
        enum BookmarkButton {
            static let padding: CGFloat = 8
        }
    }
}
