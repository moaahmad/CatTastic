//
//  String+Extensions.swift
//  CatTastic
//
import Foundation

extension String {
    /// Convenience method for string localization.
    /// Eliminates need for using NSLocalizedString
    /// Usage:  "Localization_Key".localized
    /// - Returns: The localized string
    public func localized(_ parameters: CVarArg...) -> String {
        var string = NSLocalizedString(self, comment: "")
        if string == self {
            string = NSLocalizedString(self, tableName: nil, bundle: .main, value: self, comment: "")
        }
        return String(format: string, arguments: parameters)
    }
}
