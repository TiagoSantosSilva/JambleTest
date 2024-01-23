//
//  Currency.swift
//  JambleTest
//
//  Created by Tiago Silva on 21/01/2024.
//

import Foundation

enum Currency: String {
    case usd = "USD"
    case eur = "EUR"
    case gbp = "GBP"
    
    enum PricePosition {
        case leading
        case trailing
    }
    
    enum Separator {
        case comma
        case dot
        
        var symbol: String {
            switch self {
            case .comma:
                return ","
            case .dot:
                return "."
            }
        }
    }
    
    var position: PricePosition {
        switch self {
        case .usd, .gbp:
            return .leading
        case .eur:
            return .trailing
        }
    }
    
    var separator: Separator {
        switch self {
        case .usd, .gbp:
            return .dot
        case .eur:
            return .comma
        }
    }
    
    var symbol: String {
        switch self {
        case .usd:
            return "$"
        case .eur:
            return "€"
        case .gbp:
            return "£"
        }
    }
}
