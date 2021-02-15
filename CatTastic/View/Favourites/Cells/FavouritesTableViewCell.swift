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
extension FavouritesTableViewCell: CellImageProtocol {
    func configureCell(for catBreed: CatBreed) {
        titleLabel.text = catBreed.name
        subtitleLabel.text = catBreed.origin
        configureImageView(with: catBreed,
                           imageView: favouriteImageView,
                           gradientView: gradientView)
    }
}
