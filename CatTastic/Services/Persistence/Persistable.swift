//
//  Persistable.swift
//  CatTastic
//
import Foundation

protocol Persistable {
    func updateWith(cat: CatBreed, actionType: PersistenceActionType, completion: @escaping (PersistenceError?) -> Void)
    func retrieveFavourites(completion: @escaping (Result<[CatBreed], PersistenceError>) -> Void)
    func save(favourites: [CatBreed]) -> PersistenceError?
}
