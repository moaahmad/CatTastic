//
//  Breed.swift
//  CatTastic
//
import Foundation

struct CatBreed: Codable, Hashable {
    let id: String?
    let name: String?
    let description: String?
    let temperament: String?
    let lifeSpan: String?
    let alternativeNames: String?
    let wikipediaURL: String?
    let origin: String?
    let weight: Weight?
    let image: Image?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case temperament
        case lifeSpan = "life_span"
        case alternativeNames = "alt_names"
        case wikipediaURL = "wikipedia_url"
        case origin
        case weight
        case image
    }
    
    static func == (lhs: CatBreed, rhs: CatBreed) -> Bool {
        lhs.id == rhs.id
    }
}
