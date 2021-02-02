//
//  DynamicValue.swift
//  CatTastic
//
import Foundation

/// In order to be able to achieve the required MVVM bindings, this Dynamic Value
/// class has been created utilising `didSet` property observers.
class DynamicValue<T> {
    typealias Completion = (T) -> Void
    
    var value: T {
        didSet {
            self.notify()
        }
    }
    
    private var observers = [String: Completion]()
    
    init(_ value: T) {
        self.value = value
    }
    
    func addAndNotify(observer: NSObject, completion: @escaping Completion) {
        addObserver(observer, completion: completion)
        notify()
    }

    func addObserver(_ observer: NSObject, completion: @escaping Completion) {
        observers[observers.description] = completion
    }
    
    private func notify() {
        observers.forEach { $0.value(value) }
    }
    
    deinit {
        observers.removeAll()
    }
}
