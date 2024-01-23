//
//  Cancellables.swift
//  JambleTest
//
//  Created by Tiago Silva on 22/01/2024.
//

import Combine
import Foundation

final class Cancellables {
    var storage: Set<AnyCancellable> = []
    static var shared: Cancellables = .init()
    
    private init() {}
}
