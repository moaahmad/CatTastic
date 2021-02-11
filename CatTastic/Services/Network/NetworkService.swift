//
//  NetworkService.swift
//  CatTastic
//
import Foundation

// CR: Make this service more specific - network service means what? could be anything ...
final class NetworkService {
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
