//
//  ProductCellViewModel.swift
//  JambleTest
//
//  Created by Tiago Silva on 21/01/2024.
//

import Foundation

final class ProductCellViewModel: Hashable {
    let uuid: UUID = UUID()
    let id: Int
    let color: String
    let title: String
    let priceText: String
    let price: Float
    let size: String
    let image: URL?
    var isBookmarked: Bool = false
    var bookmarkCount: Int = Int.random(in: 10...100)
    
    init(product: Product) {
        self.id = product.id
        self.color = product.color
        self.title = product.title
        self.priceText = PriceFactory.makeString(price: product.price, currency: product.currency)
        self.price = product.price
        self.size = product.size
        self.image = Self.mockImages.randomElement()
    }
    
    func toggleBookmark() {
        isBookmarked.toggle()
        bookmarkCount = isBookmarked ? (bookmarkCount + 1) : (bookmarkCount - 1)
    }
    
    static func == (lhs: ProductCellViewModel, rhs: ProductCellViewModel) -> Bool {
        lhs.id == rhs.id
        && lhs.color == rhs.color
        && lhs.title == rhs.title
        && lhs.price == rhs.price
        && lhs.size == rhs.size
        && lhs.image == rhs.image
        && lhs.isBookmarked == rhs.isBookmarked
        && lhs.bookmarkCount == rhs.bookmarkCount
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(uuid)
    }
}

// MARK: - Mocked Images

/// These static URLs are being used only for the exercise's purpose.
/// In a real scenario we would get these from the backend's response.
private extension ProductCellViewModel {
    static let mockImages: [URL] = [
        .init(string: "https://imgproxy.johnhenric.com/preset:sharp/resize:fit:1280/gravity:nowe/quality:80/aHR0cHM6Ly9qb2huaGVucmljLmNlbnRyYWNkbi5uZXQvY2xpZW50L2R5bmFtaWMvaW1hZ2VzLzEyNjJfNDU1M2QxMGI1MC1hMDEyODMtMDgtMS1vcmlnaW5hbC5qcGc=")!,
        .init(string: "https://images.hugoboss.com/is/image/boss/hbeu50517925_357_360?$large$=&fit=crop,1&align=1,1&lastModified=1705498732000&wid=450&fmt=webp")!,
        .init(string: "https://images.hugoboss.com/is/image/boss/hbeu50475284_265_100?$re_fullPageZoom$&qlt=85&fit=crop,1&align=1,1&lastModified=1703801143000&wid=1600&hei=2424&fmt=webp")!
    ]
}
