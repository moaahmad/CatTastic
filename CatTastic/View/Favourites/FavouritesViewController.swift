//
//  FavouritesViewController.swift
//  CatTastic
//
import UIKit

final class FavouritesViewController: BaseViewController {
    // MARK: - IBOutlets
    @IBOutlet private(set) var tableView: UITableView!
    
    // MARK: - Properties
    let dataSource = FavouritesDataSource()
    
    lazy var viewModel: FavouritesViewModel = {
        return FavouritesViewModel(dataSource: dataSource)
    }()
    
    lazy var noFavouritesView: UIView = {
        let nibView = UINib(nibName: "NoFavouritesView", bundle: .main)
            .instantiate(withOwner: nil, options: nil).first as? UIView
        guard let view = nibView else { return UIView() }
        return view
    }()
        
    // MARK: - View Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "favourites_tab_title".localized()
        configureTableView()
        dataSource.data.addAndNotify(observer: self) { [weak self] _ in
            self?.updateUI(with: self?.viewModel.favourites ?? [])
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetchFavourites { error in
            if error != nil {
                self.coordinator?.presentOkAlert(title: "error_title".localized(),
                                                 message: error?.rawValue,
                                                 alertTitle: "okay_action_title".localized())
            }
        }
        updateUI(with: viewModel.favourites)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}

// MARK: - Functions
extension FavouritesViewController {
    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = dataSource
        let nib = UINib(nibName: FavouritesTableViewCell.nibID, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: FavouritesTableViewCell.cellID)
    }
    
    func updateUI(with favourites: [CatBreed]) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            if favourites.isEmpty {
                self.showNoFavouritesView()
            } else {
                self.noFavouritesView.removeFromSuperview()
                self.tableView.isHidden = false
                self.view.bringSubviewToFront(self.tableView)
                self.tableView.reloadData()
            }
        }
    }
    
    private func showNoFavouritesView() {
        tableView.isHidden = true
        view.addSubview(noFavouritesView)
        noFavouritesView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            noFavouritesView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            noFavouritesView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            noFavouritesView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            noFavouritesView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12)
        ])
    }
}

// MARK: - UITableViewDelegate
extension FavouritesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let coordinator = coordinator as? FavouritesCoordinator {
            coordinator.showBreedDetail(for: viewModel.favourites[indexPath.row])
        }
    }
}
