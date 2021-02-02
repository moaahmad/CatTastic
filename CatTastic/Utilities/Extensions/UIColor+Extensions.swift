//
//  UIColor+Extensions.swift
//  CatTastic
//
import UIKit

extension UIColor {
    class var tintGreen: UIColor {
        let dynamicColor = UIColor.systemGreen
        return dynamicColor.resolvedColor(with: UITraitCollection(accessibilityContrast: .high))
    }
}
