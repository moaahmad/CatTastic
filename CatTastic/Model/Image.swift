//
//  Image.swift
//  CatTastic
//
import Foundation

struct Image: Codable, Hashable {
    let id: String?
    let url: String?
    let categories: [Category]?
    let breeds: [CatBreed]?
    
    static func == (lhs: Image, rhs: Image) -> Bool {
        lhs.id == rhs.id
    }
}
