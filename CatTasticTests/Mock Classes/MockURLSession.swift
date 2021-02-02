//
//  MockURLSession.swift
//  CatTasticTests
//
import Foundation
@testable import CatTastic

final class MockURLSession: NSObject, DataTaskable {

    typealias CompletionHandler = (Data?, URLResponse?, Error?) -> Void
    typealias Request = (url: URL?, httpBody: Data?, completionHandler: CompletionHandler?)

    var requests: [Request] = []
    private var currentTasks = [MockTask]()

    static func successResponse() -> HTTPURLResponse? {
        HTTPURLResponse(url: URL(string: "https://www.example.com")!,
                        statusCode: 200,
                        httpVersion: nil,
                        headerFields: nil)
    }

    func dataTask(with request: URLRequest,
                  completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        requests.append((url: request.url,
                         httpBody: request.httpBody,
                         completionHandler: completionHandler))
        let mockTask = MockTask()
        mockTask.request = request
        currentTasks.append(mockTask)
        return mockTask
    }
}

// MARK: - Accessors
extension MockURLSession {
    var url: URL? {
        requests.last?.url
    }

    var httpBody: Data? {
        requests.last?.httpBody
    }

    var completionHandler: CompletionHandler? {
        requests.last?.completionHandler
    }

    @objc var requestCount: Int {
        requests.count
    }
}

private final class MockTask: URLSessionDataTask {
    var request: URLRequest?
    private var currentState: URLSessionTask.State = .suspended

    override var state: URLSessionTask.State {
        return currentState
    }
    override var originalRequest: URLRequest? {
        return request
    }

    override init() { }
    override func resume() {
        currentState = .running
    }
    override func cancel() {
        currentState = .canceling
    }
    override func suspend() {
        currentState = .suspended
    }
}
