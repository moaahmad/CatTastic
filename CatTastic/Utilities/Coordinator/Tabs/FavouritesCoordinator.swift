//
//  FavouritesCoordinator.swift
//  CatTastic
//
import UIKit

final class FavouritesCoordinator: Coordinator {
    weak var parentCoordinator: Coordinator?
    var rootController: UIViewController?
    var client: NetworkClient?

    init(navigationController: UINavigationController, client: NetworkClient?) {
        self.rootController = navigationController
        self.client = client
    }
    
    func start() {
        let vc = FavouritesViewController.instantiate()
        vc.coordinator = self
        vc.client = client
        navigationController?.pushViewController(vc, animated: false)
    }
    
    func showBreedDetail(for catBreed: CatBreed) {
        let vc = CatBreedsDetailViewController.instantiate()
        vc.coordinator = self
        vc.viewModel = CatBreedDetailViewModel(catBreed: catBreed)
        navigationController?.pushViewController(vc, animated: true)
    }
}
