//
//  CatBreedDetailViewModel.swift
//  CatTastic
//
import UIKit

struct CatBreedDetailViewModel {
    // MARK: - Properties
    let persistenceManager: Persistable

    var catBreed: CatBreed!
    var isAlreadyFavourite: Bool {
        var isAlreadyFavourite = false
        persistenceManager.retrieveFavourites { result in
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
    init(catBreed: CatBreed,
         persistence: Persistable = PersistenceManager.shared) {
        self.catBreed = catBreed
        self.persistenceManager = persistence
    }
}

// MARK: - Functions
extension CatBreedDetailViewModel {
    func updateFavourites(completion: @escaping (Bool) -> Void) {
        var isFavourite = isAlreadyFavourite
        isFavourite.toggle()

        persistenceManager.updateWith(cat: catBreed,
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
