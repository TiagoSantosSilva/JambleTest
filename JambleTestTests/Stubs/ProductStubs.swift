//
//  ProductStubs.swift
//  JambleTestTests
//
//  Created by Tiago Silva on 22/01/2024.
//

@testable import JambleTest

extension Product {
    static let stub: [Product] = [
        .init(id: 1, color: "#FF5733", title: "Vintage Denim Jacket", price: 49.99, currency: "USD", size: "M"),
        .init(id: 2, color: "#FFC300", title: "Retro Leather Boots", price: 89.99, currency: "USD", size: "L"),
        .init(id: 3, color: "#DAF7A6", title: "Classic Flannel Shirt", price: 34.99, currency: "USD", size: "S"),
        .init(id: 4, color: "#FF5733", title: "Bohemian Maxi Dress", price: 59.99, currency: "USD", size: "M"),
        .init(id: 5, color: "#C70039", title: "Vintage Graphic Tee", price: 24.99, currency: "USD", size: "XL"),
        .init(id: 6, color: "#FFC300", title: "Retro High-Waisted Jeans", price: 54.99, currency: "USD", size: "L"),
        .init(id: 7, color: "#581845", title: "Classic Tweed Blazer", price: 79.99, currency: "USD", size: "M"),
        .init(id: 8, color: "#DAF7A6", title: "Silk Scarf", price: 19.99, currency: "USD", size: "S"),
        .init(id: 9, color: "#C70039", title: "Vintage Wool Coat", price: 99.99, currency: "USD", size: "XL"),
        .init(id: 10, color: "#581845", title: "Retro Sunglasses", price: 15.99, currency: "USD", size: "S"),
        .init(id: 11, color: "#FF5733", title: "Leather Messenger Bag", price: 110.00, currency: "USD", size: "M"),
        .init(id: 12, color: "#FFC300", title: "Embroidered Denim Skirt", price: 45.99, currency: "USD", size: "L"),
        .init(id: 13, color: "#DAF7A6", title: "Faux Fur Vest", price: 65.99, currency: "USD", size: "XL"),
        .init(id: 14, color: "#C70039", title: "Retro Polka Dot Dress", price: 39.99, currency: "USD", size: "S"),
        .init(id: 15, color: "#581845", title: "Vintage Fedora Hat", price: 29.99, currency: "USD", size: "M")
    ]
}
