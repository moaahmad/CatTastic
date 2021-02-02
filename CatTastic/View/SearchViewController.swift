//
//  ViewController.swift
//  CoordinatorPractice
//
//  Created by Mohammed Ahmad on 1/23/21.
//
import UIKit

class CatBreedsViewController: UIViewController, Storyboarded {
    weak var coordinator: Coordinator?
    var client: NetworkClient?
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private let itemsPerRow: CGFloat = 2
    private let sectionInsets = UIEdgeInsets(top: 20.0,
                                             left: 20.0,
                                             bottom: 20.0,
                                             right: 20.0)
    var catBreeds = [Breed]()
    var filteredCatBreeds = [Breed]()
    
    var isFiltering: Bool = false
    
    var currentDataSource: [Breed] {
        isFiltering ? filteredCatBreeds : catBreeds
    }
    
    private lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "Search for any breed of cat!"
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
        return searchController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Cat Breeds"
        //
        configureCollectionView()
        //
        configureSearchBar()
        //
        fetchCatBreeds()
    }
    
    func configureCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        // Register Nib
        let nib = UINib(nibName: BreedCollectionViewCell.nibName, bundle: nil)
        collectionView?.register(nib, forCellWithReuseIdentifier: BreedCollectionViewCell.cellID)
    }
    
    func configureSearchBar() {
        navigationController?.navigationItem.searchController = searchController
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false

    }
    
    func fetchCatBreeds() {
        SearchService.fetchBreedsList(client: client) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    self?.catBreeds = data
                    self?.collectionView.reloadData()
                    print(self!.catBreeds)
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}

// MARK: - UICollectionViewDelegate & UICollectionViewDataSource
extension CatBreedsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        currentDataSource.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BreedCollectionViewCell.cellID,
                                                            for: indexPath) as? BreedCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.configureCell(for: currentDataSource[indexPath.row])
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension CatBreedsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow

        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        sectionInsets.left
    }
}

// MARK: - UISearchBarDelegate
extension CatBreedsViewController: UISearchBarDelegate, UISearchResultsUpdating {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let searchText = searchText.filter {
            $0.isLetter || !$0.isNumber || " ".contains($0) || !$0.isSymbol
        }.lowercased()
        
        isFiltering = !searchText.isEmpty
        guard isFiltering else { return }
        filteredCatBreeds = catBreeds.filter {
            $0.name!.lowercased().contains(searchText)
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isFiltering = false
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        collectionView.reloadData()
    }
}
