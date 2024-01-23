//
//  UIView+Animation.swift
//  JambleTest
//
//  Created by Tiago Silva on 22/01/2024.
//

import UIKit

extension UIView {
    func bounce() {
        UIView.animate(withDuration: 0.2, animations: {
            self.transform = CGAffineTransform(scaleX: 1.05, y: 1.05)
        }) { _ in
            UIView.animate(withDuration: 0.2) {
                self.transform = .identity
            }
        }
    }
    
    func fade(completion: @escaping () -> Void) {
        UIView.transition(with: self,
                          duration: 0.2,
                          options: .transitionCrossDissolve) {
            completion()
        }
    }
}
