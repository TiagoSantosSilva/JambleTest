//
//  MockBundleEngine.swift
//  JambleTestTests
//
//  Created by Tiago Silva on 22/01/2024.
//

@testable import JambleTest
import Foundation

final class MockBundleEngine: BundleEngineProtocol {
    
    var loadHandler: (() -> Decodable)?
    
    func load<T: Decodable>(content: JambleTest.BundleContent) throws -> T {
        switch content {
        case .products:
            guard let loadHandler else { fatalError() }
            return loadHandler() as! T
        }
    }
}
