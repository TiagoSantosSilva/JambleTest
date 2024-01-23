//
//  GradientView.swift
//  JambleTest
//
//  Created by Tiago Silva on 22/01/2024.
//

import UIKit

final class GradientView: UIView {
    
    private let gradient = CAGradientLayer()
    
    init() {
        super.init(frame: .zero)
        gradient.startPoint = .init(x: 0, y: 0)
        gradient.endPoint = .init(x: 0, y: 1)
        layer.insertSublayer(gradient, at: 0)
    }
    
    required init?(coder: NSCoder) {
        nil
    }
    
    func constraint(to bounds: CGRect) {
        gradient.frame = bounds
    }
    
    func setupColor(_ color: UIColor) {
        gradient.colors = [
            UIColor.systemBackground.withAlphaComponent(0.05).cgColor,
            UIColor.systemBackground.cgColor
        ]
    }
}
