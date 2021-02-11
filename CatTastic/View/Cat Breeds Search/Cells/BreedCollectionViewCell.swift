//
//  BreedCollectionViewCell.swift
//  CatTastic
//
import UIKit

final class BreedCollectionViewCell: UICollectionViewCell {
    static let cellID = "BreedCollectionCell" // TPC: this is interesting, why like this and not in the storboard
    static let nibName = "BreedCollectionViewCell" // TPC: why not use the class name for this
    
    // MARK: - IBOutlets
    @IBOutlet private(set) var cellView: UIView! {
        didSet {
            cellView.layer.masksToBounds = true
            cellView.layer.cornerRadius = 20
            cellView.heightAnchor.constraint(equalToConstant: 230).isActive = true // TPC: Same here .. why here and not on the storyboard
        }
    }
    @IBOutlet private(set) var imageView: UIImageView!
    @IBOutlet private(set) var gradientView: UIView!
    @IBOutlet private(set) var breedNameLabel: UILabel!

    // MARK: - Override Methods
    override func prepareForReuse() {
        super.prepareForReuse() // TPC: WHYYYYYYYYYYYYY - demonstration of knowledge of table views
        gradientView.removeLayer(layerName: "Gradient")
    }
}

// MARK: - Functions
extension BreedCollectionViewCell {
    func configureCell(for catBreed: CatBreed) { // TPC: why dependency injection
        breedNameLabel.text = catBreed.name
        configureImageView(with: catBreed)
    }

    private func configureImageView(with catBreed: CatBreed) {
        guard let catImage = catBreed.image,
              catImage.url != nil else {
            imageView.image = UIImage(named: "placeholder")
            return
        }
        gradientView.addGradientLayer(withColors: [.clear, .darkGray]) // TPC: sweet, I know you're flexing now, fo sho
        imageView.setImage(for: catImage.url)
    }
}
