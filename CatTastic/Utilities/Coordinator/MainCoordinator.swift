//
//  MainCoordinator.swift
//  CatTastic
//
import UIKit

final class MainCoordinator: Coordinator {
    var rootController: UIViewController?
    var childCoordinators: [Coordinator] = [Coordinator]()
    var tabBarController: UITabBarController
    var client: NetworkClient?
    
    init(tabBarController: UITabBarController,
         client: NetworkClient?) {
        self.tabBarController = tabBarController
        self.client = client
    }
    
    func start() {
        let catBreedsNavigationController = UINavigationController()
        catBreedsNavigationController.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        let catBreedsCoordinator = CatBreedsCoordinator(navigationController: catBreedsNavigationController,
                                                        client: client)
        catBreedsCoordinator.parentCoordinator = self
        catBreedsCoordinator.start()
        childCoordinators.append(catBreedsCoordinator)

        let favouritesNavigationController = UINavigationController()
        favouritesNavigationController.tabBarItem = UITabBarItem(title: "Favourites",
                                                                 image: UIImage(systemName: "heart.fill"), tag: 1)
        let favouritesCoordinator = FavouritesCoordinator(navigationController: favouritesNavigationController,
                                                          client: client)
        favouritesCoordinator.parentCoordinator = self
        favouritesCoordinator.start()
        childCoordinators.append(favouritesCoordinator)

        tabBarController.viewControllers = [catBreedsNavigationController, favouritesNavigationController]
    }
}
