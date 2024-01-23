//
//  UIViewController.swift
//  JambleTest
//
//  Created by Tiago Silva on 21/01/2024.
//

import UIKit

public extension UIViewController {
    func add(_ child: UIViewController) {
        add(child, to: view)
    }
    
    func add(_ child: UIViewController, to view: UIView) {
        view.addSubview(child.view)
        addChild(child)
        child.didMove(toParent: self)
    }
}
