//
//  UIView+Extensions.swift
//  CatTastic
//
import UIKit

extension UIView {
    func addGradientLayer(withColors colors: [UIColor]) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.name = "Gradient"
        gradientLayer.colors = colors.map {
            $0.cgColor
        }
        gradientLayer.locations = [0.3, 1]
        layer.addSublayer(gradientLayer)
        gradientLayer.frame = layer.frame
    }

    func removeLayer(layerName: String) {
        for item in self.layer.sublayers ?? [] where item.name == layerName {
            item.removeFromSuperlayer()
        }
    }
}
