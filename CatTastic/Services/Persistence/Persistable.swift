//
//  Persistable.swift
//  CatTastic
//
import Foundation

protocol Persistable {
    static func updateWith(cat: CatBreed, actionType: PersistenceActionType, completion: @escaping (PersistenceError?) -> Void)
    static func retrieveFavourites(completion: @escaping (Result<[CatBreed], PersistenceError>) -> Void)
    static func save(favourites: [CatBreed]) -> PersistenceError?
}
