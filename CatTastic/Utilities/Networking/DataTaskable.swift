//
//  DataTaskable.swift
//  CatTastic
//
import Foundation

protocol DataTaskable {
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

extension URLSession: DataTaskable { }
