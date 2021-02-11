//
//  ViewController.swift
//  CatTastic
//
import UIKit

final class CatBreedsViewController: BaseViewController {
    // MARK: - IBOutlets
    @IBOutlet private(set) var collectionView: UICollectionView!
    
    // MARK: - Internal Properties
    private let dataSource = CatBreedsDataSource()
    private var viewModel: CatBreedsViewModel!
    
    // TPC: Why lazy 
    private lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "search_bar_placeholder".localized()
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
        return searchController
    }()
    
    // MARK: - View Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // TPC: Explain why in future you may split this into other methods i.e. setupView(), setupData()
        configureNavigationBar()
        configureCollectionView()
        dataSource.configureDataSource(for: collectionView)
        configureViewModel()
        configureSearchBar()
        loadCatBreeds()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}

// MARK: - Functions
extension CatBreedsViewController {
    func configureNavigationBar() {
        title = "search_tab_title".localized() // TPC: why strings file
        navigationItem.backButtonTitle = "back".localized()
    }
    
    func configureCollectionView() {
        collectionView.collectionViewLayout = createTwoColumnFlowLayout(in: view)
        collectionView.delegate = self
        collectionView.backgroundColor = .systemBackground
        collectionView.keyboardDismissMode = .interactive
        
        let nib = UINib(nibName: BreedCollectionViewCell.nibName, bundle: nil)
        collectionView?.register(nib, forCellWithReuseIdentifier: BreedCollectionViewCell.cellID)
    }
    
    func configureViewModel() {
        guard let client = client else { return }
        viewModel = CatBreedsViewModel(client: client,
                                       dataSource: dataSource)
    }
    
    func configureSearchBar() {
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    func loadCatBreeds() {
        showLoadingView()
        viewModel.fetchCatBreeds { result in
            switch result {
            case .success:
                self.dismissLoadingView()
            case .failure(let error):
                self.coordinator?.presentOkAlert(title: "error_title".localized(),
                                                 message: "\(error)",
                                                 alertTitle: "okay_action_title".localized())
            }
        }
    }
}

// MARK: - UICollectionViewDelegate
extension CatBreedsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let coordinator = coordinator as? CatBreedsCoordinator {
            coordinator.showBreedDetail(for: viewModel.currentDataSource[indexPath.item])
        }
    }
}

// MARK: - UISearchBarDelegate
extension CatBreedsViewController: UISearchBarDelegate, UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text, !searchText.isEmpty else {
            viewModel.filteredCatBreeds.removeAll()
            dataSource.updateData(on: viewModel.catBreeds)
            viewModel.isFiltering = false
            return
        }
        
        let filteredText = searchText.filter {
            $0.isLetter || !$0.isNumber || " ".contains($0) || !$0.isSymbol
        }.lowercased()
        
        viewModel.isFiltering = true
        viewModel.filteredCatBreeds = viewModel.catBreeds.filter { ($0.name?.lowercased().contains(filteredText) ?? false) }
        dataSource.updateData(on: viewModel.filteredCatBreeds)
    }
}
