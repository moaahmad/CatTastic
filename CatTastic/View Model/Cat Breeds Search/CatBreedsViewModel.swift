//
//  CatBreedsViewModel.swift
//  CatTastic
//
import Foundation

final class CatBreedsViewModel: NSObject {
    // MARK: - Properties
    weak var dataSource: CatBreedsDataSource?
    weak var client: NetworkClient?

    private(set) var catBreeds = [CatBreed]()
    
    var filteredCatBreeds = [CatBreed]()
    var isFiltering: Bool = false
    var currentDataSource: [CatBreed] {
        isFiltering ? filteredCatBreeds : catBreeds
    }
    var onErrorHandling: ((HTTPError) -> Void)?
    
    // MARK: - Initializers
    init(client: NetworkClient?,
         dataSource: CatBreedsDataSource?) {
        self.client = client
        self.dataSource = dataSource
    }
}

// MARK: - Functions
extension CatBreedsViewModel {
    func fetchCatBreeds(completion: @escaping (Result<Void, Error>) -> Void) {
        guard let client = client else {
            onErrorHandling?(HTTPError.requestFailed(with: "Missing Network Client"))
            return
        }
        
        NetworkService.fetchBreedsList(client: client) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    completion(.success(()))
                    self.updateUI(with: data)
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
    
    private func updateUI(with catBreeds: [CatBreed]) {
        self.catBreeds.append(contentsOf: catBreeds)
        dataSource?.updateData(on: catBreeds)
    }
}
