//
//  Error.swift
//  CatTastic
//
import Foundation

enum PersistenceError: String, Error {
    case unableToFavourite = "There was an error favouriting this cat. Please try again."
    case alreadyInFavourites = "You've already favourited this cat!"
}

enum URLRequestError: Error {
    case requestFailed
    case unknownError
    case noDataReturned
}

enum HTTPError: Error, Equatable {
    case requestFailed(with: String)
    case noInternet
    case timedOut

    var text: String {
        switch self {
        case .noInternet:
            return "iPhone is offline. Please reconnect and try again."
        case .timedOut:
            return "Request timed out."
        case .requestFailed(let error):
            return "Request Failed - \(error)"
        }
    }
}
