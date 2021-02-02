//
//  SceneDelegate.swift
//  CatTastic
//
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    var coordinator: MainCoordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        initializeMainCoordinator()
    }
    
    private func initializeMainCoordinator() {
        let tabBarController = UITabBarController()
        tabBarController.tabBar.itemPositioning = .centered
        coordinator = MainCoordinator(tabBarController: tabBarController, client: NetworkClient())
        coordinator?.start()
    
        window?.rootViewController = coordinator?.tabBarController
        window?.makeKeyAndVisible()
    }
}
