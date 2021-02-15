//
//  NetworkService.swift
//  CatTastic
//
import Foundation

protocol NetworkServiceProtocol {
    static func fetchBreedsList(client: NetworkClient?,
                                completion: @escaping (Result<[CatBreed], Error>) -> Void)
}

final class NetworkService: NetworkServiceProtocol {
    static func fetchBreedsList(client: NetworkClient?,
                                completion: @escaping (Result<[CatBreed], Error>) -> Void) {
        let request = URLRequestPool.breedsListRequest()
        client?.executeRequest(request, completion: { result in
            switch result {
            case .success(let data):
                do {
                    let breedsList = try JSONDecoder().decode([CatBreed].self, from: data)
                    completion(.success(breedsList))
                } catch let error {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
}
