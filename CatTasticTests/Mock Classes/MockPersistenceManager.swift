//
//  MockPersistenceManager.swift
//  CatTasticTests
//
//  Created by Mohammed Ahmad on 8/2/21.
//
@testable import CatTastic

final class MockPersistenceManager: Persistable {
    var retrievalResult: Result<[CatBreed], PersistenceError> = .success([])

    func updateWith(cat: CatBreed, actionType: PersistenceActionType, completion: @escaping (PersistenceError?) -> Void) {

    }

    func retrieveFavourites(completion: @escaping (Result<[CatBreed], PersistenceError>) -> Void) {
        completion(retrievalResult)
    }

    func save(favourites: [CatBreed]) -> PersistenceError? {
        return nil
    }
}
