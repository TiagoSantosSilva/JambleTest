//
//  RoundedButton.swift
//  JambleTest
//
//  Created by Tiago Silva on 20/01/2024.
//

import UIKit

final class RoundedButton: UIButton {
    init(title: String,
         image: UIImage? = nil,
         imagePlacement: NSDirectionalRectEdge = .trailing) {
        super.init(frame: .zero)
        setTitle(title, for: .normal)
        
        var configuration = UIButton.Configuration.filled()
        configuration.baseBackgroundColor = .primaryButton
        
        configuration.contentInsets = Constants.contentInsets
        configuration.baseForegroundColor = .buttonForeground
        
        if let image {
            configuration.image = image
                .withTintColor(.label)
            configuration.imagePadding = Constants.imagePadding
            configuration.imagePlacement = imagePlacement
        }
        
        self.configuration = configuration
        
        clipsToBounds = true
        layer.cornerRadius = Constants.cornerRadius
    }
    
    required init?(coder: NSCoder) {
        nil
    }
}

private extension RoundedButton {
    enum Constants {
        static let contentInsets: NSDirectionalEdgeInsets = .init(top: 16,
                                                                  leading: 16,
                                                                  bottom: 16,
                                                                  trailing: 16)
        static let imagePadding: CGFloat = 8
        static let cornerRadius: CGFloat = 24
    }
}
