//
//  UIView.swift
//  JambleTest
//
//  Created by Tiago Silva on 22/01/2024.
//

import UIKit

extension UIView {
    func add(children: UIView...) {
        children.forEach(addSubview)
    }
}
