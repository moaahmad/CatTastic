//
//  UIImageView+Extensions.swift
//  CatTastic
//
import UIKit
import Kingfisher

extension UIImageView {
    func setImage(for urlString: String?) {
        guard let urlString = urlString else { return }
        let imageURL = URL(string: urlString)
        kf.indicatorType = .activity
        self.kf.setImage(with: imageURL)
    }
}
