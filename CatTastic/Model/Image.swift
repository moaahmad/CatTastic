//
//  Image.swift
//  CatTastic
//
import Foundation

// TPC: Could talk about codable vs encodable + decodable
// TPC: Could talk about organisation, why you split up your app this way App stuff, model stuff and more
struct Image: Codable, Hashable {
    let id: String?
    let url: String?
    let categories: [Category]?
    let breeds: [CatBreed]?
    
    static func == (lhs: Image, rhs: Image) -> Bool {
        lhs.id == rhs.id
    }
}
