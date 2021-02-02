//
//  NSObject+Extensions.swift
//  CatTastic
//
import Foundation

public extension NSObject {
    static var className: String {
        String(describing: Self.self)
    }
}
