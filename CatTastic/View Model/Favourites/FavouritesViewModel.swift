//
//  FavouritesViewModel.swift
//  CatTastic
//
import Foundation

struct FavouritesViewModel {
    // MARK: - Properties
    weak var dataSource: FavouritesDataSource!

    var favourites: [CatBreed] {
        dataSource.data.value
    }

    // MARK: - Init
    init(dataSource: FavouritesDataSource) {
        self.dataSource = dataSource
    }

    // MARK: - Functions
    func fetchFavourites(completion: @escaping (PersistenceError?) -> Void) {
        PersistenceManager.retrieveFavourites { result in
            switch result {
            case .success(let favourites):
                dataSource.data.value = favourites.sorted { $0.name ?? "" < $1.name ?? "" }
            case .failure(let error):
                completion(error)
            }
        }
    }
}
