//
//  BreedCollectionViewCell.swift
//  CatTastic
//
import UIKit

final class BreedCollectionViewCell: UICollectionViewCell {
    static let cellID = "BreedCollectionCell"
    static let nibName = "BreedCollectionViewCell"
    
    // MARK: - IBOutlets
    @IBOutlet private(set) var cellView: UIView! {
        didSet {
            cellView.layer.masksToBounds = true
            cellView.layer.cornerRadius = 20
            cellView.heightAnchor.constraint(equalToConstant: 230).isActive = true
        }
    }
    @IBOutlet private(set) var imageView: UIImageView!
    @IBOutlet private(set) var gradientView: UIView!
    @IBOutlet private(set) var breedNameLabel: UILabel!

    // MARK: - Override Methods
    override func prepareForReuse() {
        super.prepareForReuse()
        gradientView.removeLayer(layerName: "Gradient")
    }
}

// MARK: - Functions
extension BreedCollectionViewCell {
    func configureCell(for catBreed: CatBreed) {
        breedNameLabel.text = catBreed.name
        configureImageView(with: catBreed)
    }

    private func configureImageView(with catBreed: CatBreed) {
        guard let catImage = catBreed.image,
              catImage.url != nil else {
            imageView.image = UIImage(named: "placeholder")
            return
        }
        gradientView.addGradientLayer(withColors: [.clear, .darkGray])
        imageView.setImage(for: catImage.url)
    }
}
