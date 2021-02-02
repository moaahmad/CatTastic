//
//  FavouritesTableViewCell.swift
//  CatTastic
//
import UIKit

final class FavouritesTableViewCell: UITableViewCell {
    static let cellID = "FavouritesCollectionCell"
    static let nibID = "FavouritesTableViewCell"

    // MARK: - IBOutlets
    @IBOutlet weak var favouriteImageView: UIImageView!
    @IBOutlet weak var gradientView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!

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
