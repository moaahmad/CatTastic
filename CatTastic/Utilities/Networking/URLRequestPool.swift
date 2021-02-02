//
//  URLRequestPool.swift
//  CatTastic
//
import Foundation

struct URLRequestPool {
    private static let apiToken = "88f5e2aa-9ad3-4b52-a267-084cc47fdaff"
    
    private enum HTTPKeys {
        // Methods
        static let get = "GET"
        static let post = "POST"
        static let put = "PUT"
        static let delete = "DELETE"

        // Header Fields
        static let xApiKey = "x-api-key"
    }
    
    static func breedsListRequest() -> URLRequest {
        var request = URLRequest(url: URLPool.breedsURL())
        request.httpMethod = HTTPKeys.get
        request.addValue(apiToken, forHTTPHeaderField: HTTPKeys.xApiKey)
        return request
    }
}
