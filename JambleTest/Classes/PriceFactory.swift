//
//  PriceFactory.swift
//  JambleTest
//
//  Created by Tiago Silva on 21/01/2024.
//

import Foundation

enum PriceFactory {
    static func makeString(price: Float, currency: String) -> String {
        guard let currency = Currency(rawValue: currency) else { return "\(price)" }
        let integer = Self.integer(from: price)
        let fractional: String = {
            let value = "\(Self.fractional(from: price, integer: integer))"
            if value.count == 1 {
                return "\(value)0"
            }
            return value
        }()
        let symbol = currency.symbol
        let separator = currency.separator.symbol
        switch currency {
        case .usd, .gbp:
            return "\(symbol)\(integer)\(separator)\(fractional)"
        case .eur:
            return "\(integer)\(separator)\(fractional)\(symbol)"
        }
    }
    
    private static func integer(from price: Float) -> Int {
        Int(floor(price))
    }
    
    private static func fractional(from price: Float, integer: Int? = nil) -> Int {
        let integer = {
            if let integer {
                return integer
            }
            return Self.integer(from: price)
        }()
        
        return Int((price - Float(integer)) * 100)
    }
}
