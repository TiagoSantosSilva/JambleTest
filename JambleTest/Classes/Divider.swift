//
//  Divider.swift
//  JambleTest
//
//  Created by Tiago Silva on 20/01/2024.
//

import UIKit

final class Divider: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .divider
    }
    
    required init?(coder: NSCoder) {
        nil
    }
}
