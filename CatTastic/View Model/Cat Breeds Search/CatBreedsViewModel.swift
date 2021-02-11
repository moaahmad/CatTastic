//
//  CatBreedsViewModel.swift
//  CatTastic
//
import Foundation

// CR: why does this need to be an NSOBject
final class CatBreedsViewModel: NSObject {
    // MARK: - Properties
    weak var dataSource: CatBreedsDataSource?
    weak var client: NetworkClient?

    private(set) var catBreeds = [CatBreed]()
    
    // CR: I would recommend making all of these private set, you may have dependencies on each variable, one connected to the other ... you would want each one to be private set so you can control what happens say when you add an item to the [CatBreed] .. and so that no-one outside the module can edit it ...
    var filteredCatBreeds = [CatBreed]()
    var isFiltering: Bool = false
    var currentDataSource: [CatBreed] {
        isFiltering ? filteredCatBreeds : catBreeds
    }
    var onErrorHandling: ((HTTPError) -> Void)? // TPC: Retain cycle potential here if not used properply maybe worth talking about
    
    // CR: do these need to be optional
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
