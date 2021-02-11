//
//  PersistenceManager.swift
//  CatTastic
//
import Foundation

enum PersistenceActionType {
    case add, remove
}

struct PersistenceManager: Persistable {
    static private let defaults = UserDefaults.standard // TPC: one static instance
    
    enum Keys {
        static let favourites = "favourites" // CR: make this an string enum
    }
    
    // TPC: No need for weak self as there is no chance of a reference cycle given that this file is static
    static func updateWith(cat: CatBreed,
                           actionType: PersistenceActionType,
                           completion: @escaping (PersistenceError?) -> Void) {
        retrieveFavourites { result in
            switch result {
            case .success(var favourites):
                switch actionType {
                case .add:
                    guard !favourites.contains(cat) else {
                        completion(.alreadyInFavourites)
                        return
                    }
                    favourites.append(cat)
                case .remove:
                    favourites.removeAll { $0.id == cat.id }
                }
                completion(save(favourites: favourites))
            case .failure(let error):
                completion(error)
            }
        }
    }
    
    // TPC: could talk about why you made this escaping (also does this need to be escaping)
    static func retrieveFavourites(completion: @escaping (Result<[CatBreed], PersistenceError>) -> Void) {
        guard let favouritesData = defaults.object(forKey: Keys.favourites) as? Data else {
            completion(.success([])) // CR: would this not be better as a failure (I don't know) but it seems here that you were not able to do what you hoped to
            return
        }
        do {
            let favourites = try JSONDecoder().decode([CatBreed].self, from: favouritesData)
            completion(.success(favourites))
        } catch {
            completion(.failure(.unableToFavourite))
        }
    }
    
    static func save(favourites: [CatBreed]) -> PersistenceError? { // CR: I think that this func should throw, then higher up you can try? ... this way this class is conrete
        do {
            let encodedFavorites = try JSONEncoder().encode(favourites)
            defaults.set(encodedFavorites, forKey: Keys.favourites)
            return nil
        } catch {
            return .unableToFavourite
        }
    }
}
