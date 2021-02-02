//
//  Coordinator.swift
//  CatTastic
//
import UIKit
import SafariServices

protocol Coordinator: class {
    var rootController: UIViewController? { get }
    var client: NetworkClient? { get set }
    func start()
}

// MARK: - Router Methods
extension Coordinator {
    var navigationController: UINavigationController? {
        rootController as? UINavigationController
    }
    
    func setRootViewController(viewController: UIViewController,
                               hideBar: Bool = false,
                               animated: Bool = true) {
        navigationController?.setViewControllers([viewController], animated: animated)
        navigationController?.setNavigationBarHidden(hideBar, animated: animated)
    }

    func pushViewController(viewController: UIViewController,
                            animated: Bool = true) {
        navigationController?.pushViewController(viewController, animated: animated)
    }

    func popViewController(animated: Bool = true) {
        navigationController?.popViewController(animated: animated)
    }

    func presentViewController(viewController: UIViewController, animated: Bool = true) {
        navigationController?.present(viewController, animated: animated, completion: nil)
    }

    func dismissViewController(animated: Bool = true) {
        navigationController?.dismiss(animated: animated, completion: nil)
    }
}

// MARK: Alerts
extension Coordinator {
    func alertController(title: String?,
                         message: String?,
                         style: UIAlertController.Style,
                         actions: [UIAlertAction]) -> UIAlertController {
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: style)
        for action in actions {
            alertController.addAction(action)
        }
        return alertController
    }

    func presentOkAlert(title: String?, message: String?, alertTitle: String?) {
        let okAction = UIAlertAction(title: alertTitle, style: .default, handler: nil)
        presentAlertController(title: title,
                               message: message,
                               style: .alert,
                               actions: [okAction],
                               completion: nil)
    }

    func presentAlertController(title: String?, message: String?,
                                style: UIAlertController.Style,
                                actions: [UIAlertAction],
                                completion: (() -> Void)?) {
        let alertController = self.alertController(title: title,
                                                   message: message,
                                                   style: style,
                                                   actions: actions)
        DispatchQueue.main.async {
            self.presentViewController(viewController: alertController)
        }
    }
}

// MARK: - Safari VC
extension Coordinator {
    func presentSafariVC(with url: URL) {
        let safariVC = SFSafariViewController(url: url)
        safariVC.preferredControlTintColor = .tintGreen
        navigationController?.present(safariVC, animated: true)
    }
}
