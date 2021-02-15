//
//  PersistenceManager.swift
//  CatTastic
//
import Foundation

enum PersistenceActionType {
    case add, remove
}

struct PersistenceManager: Persistable {
    static let shared = PersistenceManager()
    static private let defaults = UserDefaults.standard
    
    enum Keys {
        static let favourites = "favourites"
    }
    
    private init() { }
    
    func updateWith(cat: CatBreed,
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
    
    func retrieveFavourites(completion: @escaping (Result<[CatBreed], PersistenceError>) -> Void) {
        guard let favouritesData = PersistenceManager.defaults.object(forKey: Keys.favourites) as? Data else {
            completion(.success([]))
            return
        }
        do {
            let favourites = try JSONDecoder().decode([CatBreed].self, from: favouritesData)
            completion(.success(favourites))
        } catch {
            completion(.failure(.unableToFavourite))
        }
    }
    
    func save(favourites: [CatBreed]) -> PersistenceError? {
        do {
            let encodedFavorites = try JSONEncoder().encode(favourites)
            PersistenceManager.defaults.set(encodedFavorites, forKey: Keys.favourites)
            return nil
        } catch {
            return .unableToFavourite
        }
    }
}
