//
//  UIView.swift
//  JambleTest
//
//  Created by Tiago Silva on 19/01/2024.
//

import UIKit

enum Anchor {
    case top
    case leading
    case trailing
    case bottom
    case vertical
    case horizontal
    case all
}

extension UIView {
    func constraint(to parent: Constrainable,
                    anchors: [Anchor],
                    padding: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        
        anchors.forEach { anchor in
            switch anchor {
            case .top:
                topAnchor.constraint(equalTo: parent.topAnchor,
                                     constant: padding).isActive = true
            case .leading:
                leadingAnchor.constraint(equalTo: parent.leadingAnchor,
                                     constant: padding).isActive = true
            case .trailing:
                trailingAnchor.constraint(equalTo: parent.trailingAnchor,
                                     constant: -padding).isActive = true
            case .bottom:
                bottomAnchor.constraint(equalTo: parent.bottomAnchor,
                                     constant: -padding).isActive = true
            case .vertical:
                topAnchor.constraint(equalTo: parent.topAnchor,
                                     constant: padding).isActive = true
                bottomAnchor.constraint(equalTo: parent.bottomAnchor,
                                     constant: -padding).isActive = true
            case .horizontal:
                leadingAnchor.constraint(equalTo: parent.leadingAnchor,
                                     constant: padding).isActive = true
                trailingAnchor.constraint(equalTo: parent.trailingAnchor,
                                     constant: -padding).isActive = true
            case .all:
                topAnchor.constraint(equalTo: parent.topAnchor,
                                     constant: padding).isActive = true
                bottomAnchor.constraint(equalTo: parent.bottomAnchor,
                                     constant: -padding).isActive = true
                leadingAnchor.constraint(equalTo: parent.leadingAnchor,
                                     constant: padding).isActive = true
                trailingAnchor.constraint(equalTo: parent.trailingAnchor,
                                     constant: -padding).isActive = true
            }
        }
    }
    
    func frame(height: CGFloat? = nil, width: CGFloat? = nil) {
        if let height {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
        
        if let width {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
    }
}
