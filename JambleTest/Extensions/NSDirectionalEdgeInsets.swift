//
//  NSDirectionalEdgeInsets.swift
//  JambleTest
//
//  Created by Tiago Silva on 21/01/2024.
//

import UIKit

extension NSDirectionalEdgeInsets {
    init(withEqualValue inset: CGFloat) {
        self.init(top: inset,
                  leading: inset,
                  bottom: inset,
                  trailing: inset)
    }
}
