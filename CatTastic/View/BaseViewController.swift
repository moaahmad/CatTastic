//
//  BaseViewController.swift
//  CatTastic
//
import UIKit

class BaseViewController: UIViewController, Storyboarded {
    // MARK: - Properties
    weak var coordinator: Coordinator?
    var client: NetworkClient?

    private var containerView: UIView!

    // MARK: - View Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.tintColor = .label
        tabBarController?.tabBar.tintColor = .tintGreen
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}

// MARK: - Loading States
extension BaseViewController {
    func showLoadingView() {
        containerView = UIView(frame: view.bounds)
        let activityIndicator = UIActivityIndicatorView(style: .large)
        
        view.addSubview(containerView)
        containerView.addSubview(activityIndicator)

        containerView.backgroundColor = .systemBackground
        containerView.alpha = 0
        UIView.animate(withDuration: 0.25) {
            self.containerView.alpha = 0.8
        }
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityIndicator.centerYAnchor.constraint(equalTo: containerView.centerYAnchor, constant: 40),
            activityIndicator.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
        ])
        
        activityIndicator.startAnimating()
    }
    
    
    func dismissLoadingView() {
        DispatchQueue.main.async {
            self.containerView.removeFromSuperview()
            self.containerView = nil
        }
    }
}
