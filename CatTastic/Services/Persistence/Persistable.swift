//
//  Persistable.swift
//  CatTastic
//
import Foundation

// TPC: why a protocol ... so you can plug in whatever presistance manager you wanted
protocol Persistable {
    static func updateWith(cat: CatBreed, actionType: PersistenceActionType, completion: @escaping (PersistenceError?) -> Void)
    static func retrieveFavourites(completion: @escaping (Result<[CatBreed], PersistenceError>) -> Void)
    static func save(favourites: [CatBreed]) -> PersistenceError?
}
