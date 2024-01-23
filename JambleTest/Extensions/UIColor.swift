//
//  UIColor.swift
//  JambleTest
//
//  Created by Tiago Silva on 20/01/2024.
//

import UIKit

extension UIColor {
    static let divider: UIColor = .init(red: 236/255, green: 237/255, blue: 240/255, alpha: 1.0)
    static let primaryButton: UIColor = {
        UIColor {
            switch $0.userInterfaceStyle {
            case .light, .unspecified:
                return .init(red: 26/255, green: 26/255, blue: 26/255, alpha: 1.0)
            case .dark:
                return .white
            @unknown default:
                return .init(red: 26/255, green: 26/255, blue: 26/255, alpha: 1.0)
            }
        }
    }()
    
    static let textField: UIColor = {
        UIColor {
            switch $0.userInterfaceStyle {
            case .light, .unspecified:
                return .init(red: 246/255, green: 247/255, blue: 249/255, alpha: 1.0)
            case .dark:
                return UIColor.systemGray2
            @unknown default:
                return .init(red: 246/255, green: 247/255, blue: 249/255, alpha: 1.0)
            }
        }
    }()
    
    static let buttonForeground: UIColor = {
        UIColor {
            switch $0.userInterfaceStyle {
            case .light, .unspecified:
                return .white
            case .dark:
                return .black
            @unknown default:
                return .white
            }
        }
    }()
    
    convenience init?(hex: String) {
        // Remove any leading '#' if present
        var cleanedHex = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        cleanedHex = cleanedHex.replacingOccurrences(of: "#", with: "")
        
        var rgb: UInt64 = 0
        
        // Convert the cleaned hex string to a 64-bit unsigned integer
        Scanner(string: cleanedHex).scanHexInt64(&rgb)
        
        let red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgb & 0x0000FF) / 255.0
        
        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
}
