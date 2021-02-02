//
//  FavouritesTableViewCell.swift
//  CatTastic
//
import UIKit

final class FavouritesTableViewCell: UITableViewCell {
    static let cellID = "FavouritesCollectionCell"
    static let nibID = "FavouritesTableViewCell"

    // MARK: - IBOutlets
    @IBOutlet private(set) var favouriteImageView: UIImageView!
    @IBOutlet private(set) var gradientView: UIView!
    @IBOutlet private(set) var titleLabel: UILabel!
    @IBOutlet private(set) var subtitleLabel: UILabel!

    // MARK: - Override Methods
    override func prepareForReuse() {
        super.prepareForReuse()
        gradientView.removeLayer(layerName: "Gradient")
    }
}

// MARK: - Functions
extension FavouritesTableViewCell {
    func configureCell(for catBreed: CatBreed) {
        configureImageView(with: catBreed)
        titleLabel.text = catBreed.name
        subtitleLabel.text = catBreed.origin
    }

    private func configureImageView(with catBreed: CatBreed) {
        guard let catImage = catBreed.image,
              catImage.url != nil else {
            favouriteImageView.image = UIImage(named: "placeholder")
            return
        }
        gradientView.addGradientLayer(withColors: [.clear, .darkGray])
        favouriteImageView.setImage(for: catImage.url)
    }
}
