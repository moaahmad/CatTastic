//
//  CatBreedDetailViewModel.swift
//  CatTastic
//
import UIKit

struct CatBreedDetailViewModel {
    // MARK: - Properties
    var catBreed: CatBreed!
    var isAlreadyFavourite: Bool {
        var isAlreadyFavourite = false
        PersistenceManager.retrieveFavourites { result in
            switch result {
            case .success(let favourites):
                isAlreadyFavourite = favourites.contains { $0.id == catBreed.id }
            case .failure:
                break
            }
        }
        return isAlreadyFavourite
    }

    // MARK: - Init
    init(catBreed: CatBreed) {
        self.catBreed = catBreed
    }
}

// MARK: - Functions
extension CatBreedDetailViewModel {
    func updateFavourites(completion: @escaping (Bool) -> Void) {
        var isFavourite = isAlreadyFavourite
        isFavourite.toggle()

        PersistenceManager.updateWith(cat: catBreed,
                                      actionType: isFavourite ? .add : .remove) { _ in
            completion(isFavourite)
        }
    }

    func calculateAverageColor() -> UIColor? {
        let imageView = UIImageView()
        imageView.setImage(for: catBreed.image?.url)
        guard let image = imageView.image,
              let averageColor = image.averageColor else { return nil }
        return averageColor
    }
}
