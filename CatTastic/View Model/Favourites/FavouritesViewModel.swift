//
//  FavouritesViewModel.swift
//  CatTastic
//
import Foundation

struct FavouritesViewModel {
    // MARK: - Properties
    weak var dataSource: FavouritesDataSource?
    let persistenceManager: Persistable
    
    var favourites: [CatBreed] {
        dataSource?.data.value ?? []
    }

    // MARK: - Init
    init(dataSource: FavouritesDataSource?,
         persistenceManager: Persistable = PersistenceManager.shared) {
        self.dataSource = dataSource
        self.persistenceManager = persistenceManager
    }

    // MARK: - Functions
    func fetchFavourites(completion: @escaping (PersistenceError?) -> Void) {
        persistenceManager.retrieveFavourites { result in
            switch result {
            case .success(let favourites):
                dataSource?.data.value = favourites.sorted { $0.name ?? "" < $1.name ?? "" }
            case .failure(let error):
                completion(error)
            }
        }
    }
}
