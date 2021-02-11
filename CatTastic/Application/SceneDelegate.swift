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
        let tabBarController = UITabBarController() // CR: Can be split into another method
        tabBarController.tabBar.itemPositioning = .centered
        coordinator = MainCoordinator(tabBarController: tabBarController, client: NetworkClient()) // TPC: Can talk about constror injection (making code more modular less tightly coupled)
        
        coordinator?.start()
    
        window?.rootViewController = coordinator?.tabBarController // TAK: Can be split into another method
        window?.makeKeyAndVisible()
    }
}
