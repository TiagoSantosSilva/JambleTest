//
//  Product.swift
//  JambleTest
//
//  Created by Tiago Silva on 21/01/2024.
//

struct Product: Decodable {
    let id: Int
    let color: String
    let title: String
    let price: Float
    let currency: String
    let size: String
}
