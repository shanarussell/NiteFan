//
//  UIColor+NiteFan.swift
//  NiteFan
//
//  Color extensions for dark/light mode support
//

import UIKit

extension UIColor {
    
    // MARK: - Dynamic Colors
    static let nfBackground = UIColor { traitCollection in
        switch traitCollection.userInterfaceStyle {
        case .dark:
            return UIColor(red: 0.05, green: 0.05, blue: 0.15, alpha: 1.0)
        default:
            return UIColor(red: 0.95, green: 0.95, blue: 0.98, alpha: 1.0)
        }
    }
    
    static let nfSecondaryBackground = UIColor { traitCollection in
        switch traitCollection.userInterfaceStyle {
        case .dark:
            return UIColor(red: 0.1, green: 0.1, blue: 0.25, alpha: 1.0)
        default:
            return UIColor(red: 0.9, green: 0.9, blue: 0.95, alpha: 1.0)
        }
    }
    
    static let nfPrimaryText = UIColor { traitCollection in
        switch traitCollection.userInterfaceStyle {
        case .dark:
            return .white
        default:
            return UIColor(red: 0.1, green: 0.1, blue: 0.2, alpha: 1.0)
        }
    }
    
    static let nfSecondaryText = UIColor { traitCollection in
        switch traitCollection.userInterfaceStyle {
        case .dark:
            return .systemGray
        default:
            return .systemGray2
        }
    }
    
    static let nfAccent = UIColor { traitCollection in
        switch traitCollection.userInterfaceStyle {
        case .dark:
            return .systemIndigo
        default:
            return .systemBlue
        }
    }
    
    static let nfButtonBackground = UIColor { traitCollection in
        switch traitCollection.userInterfaceStyle {
        case .dark:
            return UIColor.systemIndigo.withAlphaComponent(0.2)
        default:
            return UIColor.systemBlue.withAlphaComponent(0.1)
        }
    }
    
    static let nfActiveButton = UIColor { traitCollection in
        switch traitCollection.userInterfaceStyle {
        case .dark:
            return UIColor.systemBlue.withAlphaComponent(0.4)
        default:
            return UIColor.systemBlue.withAlphaComponent(0.3)
        }
    }
    
    // MARK: - Gradient Colors
    static func nfGradientColors(for traitCollection: UITraitCollection) -> [CGColor] {
        switch traitCollection.userInterfaceStyle {
        case .dark:
            return [
                UIColor(red: 0.05, green: 0.05, blue: 0.15, alpha: 1.0).cgColor,
                UIColor(red: 0.1, green: 0.1, blue: 0.25, alpha: 1.0).cgColor,
                UIColor(red: 0.05, green: 0.05, blue: 0.2, alpha: 1.0).cgColor
            ]
        default:
            return [
                UIColor(red: 0.95, green: 0.95, blue: 1.0, alpha: 1.0).cgColor,
                UIColor(red: 0.9, green: 0.92, blue: 0.98, alpha: 1.0).cgColor,
                UIColor(red: 0.93, green: 0.95, blue: 1.0, alpha: 1.0).cgColor
            ]
        }
    }
}