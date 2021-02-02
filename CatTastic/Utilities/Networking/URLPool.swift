//
//  URLPool.swift
//  CatTastic
//
import Foundation

struct URLPool {
    enum Keys {
        static let page = "page"
    }

    static let host = "https"
    static let api = "api.thecatapi.com"
    static let randomImagePath = "/v1/images/search"
    static let breedsPath = "/v1/breeds"
    
    static func breedsURL() -> URL {
        let queryParams = [
            URLQueryItem(name: "page", value: "0")
        ]
        return URLPool.configureURL(path: URLPool.breedsPath, parameters: queryParams)
    }
}

// MARK: - Helper Methods
extension URLPool {
    private static func configureURL(path: String,
                                     parameters: [URLQueryItem]?) -> URL {
        let components = configureComponents(path: path,
                                             parameters: parameters)
        guard let url = components.url else {
            fatalError("Url is not correctly configured")
        }
        return url
    }
    
    private static func configureComponents(path: String,
                                            parameters: [URLQueryItem]?) -> URLComponents {
        var components = URLComponents()
        components.scheme = URLPool.host
        components.host = URLPool.api
        components.path = path
        components.queryItems = parameters
        return components
    }
}
