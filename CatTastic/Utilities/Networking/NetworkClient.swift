//
//  NetworkClient.swift
//  CatTastic
//
import Foundation

// CR: Split NetworkClient into a protocol
// TPC: Talk about how having it as a protocol allows you to have whatever client you wanted, say you wanted AF networking or AlamoFire
final class NetworkClient {
    var session: DataTaskable = URLSession.shared
    
    func executeRequest(_ request: URLRequest,
                        completion: @escaping (Result<Data, Error>) -> Void) {
        session.dataTask(with: request) { data, response, error in
            if let error = error {
                switch error {
                case let error as URLError where error.code == .notConnectedToInternet:
                    completion(.failure(HTTPError.noInternet))
                case let error as URLError where error.code == .timedOut:
                    completion(.failure(HTTPError.timedOut))
                default:
                    completion(.failure(URLRequestError.requestFailed))
                }
                return
            }
            
            if let response = response as? HTTPURLResponse, !response.isSuccessful {
                completion(.failure(HTTPError.requestFailed(with: response.errorString)))
                return
            }
            
            if let data = data {
                completion(.success(data))
                return
            } else {
                completion(.failure(URLRequestError.noDataReturned))
                return
            }
        }.resume()
    }
}

// TPC: file private so that it's not used eslewhere
fileprivate extension HTTPURLResponse {
    var isSuccessful: Bool {
        (200...299).contains(statusCode)
    }
    
    var errorString: String {
        HTTPURLResponse.localizedString(forStatusCode: statusCode)
    }
}
