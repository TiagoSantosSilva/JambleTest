//
//  BookmarkButton.swift
//  JambleTest
//
//  Created by Tiago Silva on 22/01/2024.
//

import Combine
import UIKit

final class BookmarkButton: UIView {
    
    let touchSubject = PassthroughSubject<Void, Never>()
    private let button = ContainedBookmarkButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
        setupStyle()
    }
    
    required init?(coder: NSCoder) {
        nil
    }
    
    func configure(isBookmarked: Bool, bookmarkCount: Int) {
        button.configure(isBookmarked: isBookmarked, bookmarkCount: bookmarkCount)
    }
    
    private func setupSubviews() {
        let blurEffect = UIBlurEffect(style: .dark)
        let blurView = UIVisualEffectView(effect: blurEffect)
        addSubview(blurView)
        blurView.constraint(to: self, anchors: [.all])
        
        addSubview(button)
        button.constraint(to: self, anchors: [.all])
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    private func setupStyle() {
        clipsToBounds = true
        layer.cornerRadius = 16
    }
    
    @objc private func buttonTapped(_ sender: UIButton) {
        touchSubject.send(())
    }
}

private final class ContainedBookmarkButton: UIButton {
    
    func configure(isBookmarked: Bool, bookmarkCount: Int) {
        var configuration = UIButton.Configuration.filled()
        configuration.image = isBookmarked ? .heartFilled : .heart
        configuration.title = "\(bookmarkCount)"
        configuration.imagePlacement = .leading
        configuration.baseBackgroundColor = .clear
        self.configuration = configuration
    }
}
