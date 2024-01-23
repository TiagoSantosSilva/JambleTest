//
//  Localized.swift
//  JambleTest
//
//  Created by Tiago Silva on 20/01/2024.
//

import Foundation

enum LocalizedStrings {
    static let color: String = String(localized: "kColor")
    static let filter: String = String(localized: "kFilter")
    static let nameAscending: String = String(localized: "kNameAscending")
    static let nameDescending: String = String(localized: "kNameDescending")
    static let priceAscending: String = String(localized: "kPriceAscending")
    static let priceDescending: String = String(localized: "kPriceDescending")
    static let reset: String = String(localized: "kReset")
    static func resultItemCount(_ count: Int) -> String {
        if count == 0 {
           return noResults
        } else if count > 1 {
            return String(format: String(localized: "kResultItemCountPlural"), "\(count)")
        } else {
            return resultItemCountSingular
        }
    }
    static func colorFilter(_ value: String, count: Int) -> String {
        String(format: String(localized: "kColorFilter"), value, "\(count)")
    }
    static func sizeFilter(_ value: String, count: Int) -> String {
        String(format: String(localized: "kSizeFilter"), value, "\(count)")
    }
    static let resultItemCountSingular: String = String(localized: "kResultItemCountSingular")
    static let noResults: String = String(localized: "kNoResults")
    static let search: String = String(localized: "kSearch")
    static let size: String = String(localized: "kSize")
    static let sortBy: String = String(localized: "kSortBy")
}
