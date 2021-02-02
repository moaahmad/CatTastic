//
//  Storyboarded.swift
//  CatTastic
//
import UIKit

protocol Storyboarded {
    var coordinator: Coordinator? { get set }
    static func instantiate() -> Self
}

extension Storyboarded where Self: UIViewController {
    static func instantiate() -> Self {
        let storyboard = UIStoryboard(name: storyboardName, bundle: Bundle.main)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: className) as? Self else {
            fatalError("Could not find View Controller named \(className)")
        }
        return viewController
    }
    
    private static var storyboardName: String {
        className.deletingSuffix("ViewController")
    }
}

fileprivate extension String {
    /// Removes the given String from the end of the string String.
    /// If the text is not present, returns the original String intact.
    ///
    /// - Parameters:
    ///     - suffix: The text to be removed, e.g. "ViewController"
    ///
    /// - Returns:
    ///     - If suffix was found, String with the suffix removed, e.g. "MainViewController" -> "Main"
    ///     - If no suffix was found, the original string intact. e.g. "MainCoordinator" -> "MainCoordinator"
    ///
    func deletingSuffix(_ suffix: String) -> String {
        guard self.hasSuffix(suffix) else { return self }
        return String(self.dropLast(suffix.count))
    }
}
