//
//  CellImageProtocol.swift
//  CatTastic
//
//  Created by Mohammed Ahmad on 13/2/21.
//
import UIKit

enum ImageStrings {
    static let placeholder = "placeholder"
}

protocol CellImageProtocol {
    func configureImageView(with catBreed: CatBreed, imageView: UIImageView, gradientView: UIView)
}

extension CellImageProtocol {
    func configureImageView(with catBreed: CatBreed, imageView: UIImageView, gradientView: UIView) {
        guard let catImage = catBreed.image,
              catImage.url != nil else {
            imageView.image = UIImage(named: ImageStrings.placeholder)
            return
        }
        gradientView.addGradientLayer(withColors: [.clear, .darkGray])
        imageView.setImage(for: catImage.url)
    }
}
