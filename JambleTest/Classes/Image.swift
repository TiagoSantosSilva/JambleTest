//
//  Image.swift
//  JambleTest
//
//  Created by Tiago Silva on 14/01/2024.
//

import UIKit

extension UIImage {
    static let search: UIImage = .init(named: "icon-search", in: Bundle.main, compatibleWith: nil)!
    static let filter: UIImage = .init(named: "icon-filter", in: Bundle.main, compatibleWith: nil)!
    static let menu: UIImage = .init(named: "icon-menu-4-dots", in: Bundle.main, compatibleWith: nil)!
    static let heart: UIImage = .init(systemName: "heart")!
    static let heartFilled: UIImage = .init(systemName: "heart.fill")!
    static let xMarkFill: UIImage = .init(systemName: "xmark.circle.fill")!
}
