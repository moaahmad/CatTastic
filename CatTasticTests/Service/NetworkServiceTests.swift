//
//  NetworkServiceTests.swift
//  CatTasticTests
//
import XCTest
@testable import CatTastic

final class NetworkServiceTests: XCTestCase {

    var session: MockURLSession!
    var client: NetworkClient!
    
    override func setUp() {
        super.setUp()
        client = NetworkClient()
        session = MockURLSession()
        client.session = session
    }

    override func tearDown() {
        client = nil
        session = nil
        super.tearDown()
    }
    
    func test_fetchBreedsList_success() {
        var catBreeds: [CatBreed]?
        let exp = expectation(description: "Fetch breeds function completion block called")

        NetworkService.fetchBreedsList(client: client) { result in
            switch result {
            case .success(let returnedCatBreeds):
                catBreeds = returnedCatBreeds
                exp.fulfill()
            case .failure(let returnedError):
                XCTFail(returnedError.localizedDescription)
            }
        }

        let data = MockServer.loadLocalJSON("breeds")
        let response = MockURLSession.successResponse()
        session.completionHandler?(data, response, nil)
        waitForExpectations(timeout: 1, handler: nil)
        
        XCTAssertNotNil(catBreeds)
    }

    func test_fetchBreedsList_networkError() {
        var error: Error?
        let exp = expectation(description: "Fetch breeds function completion block called")

        NetworkService.fetchBreedsList(client: client) { result in
            switch result {
            case .success:
                XCTFail("Expected an error to be thrown")
            case .failure(let returnedError):
                error = returnedError
                exp.fulfill()
            }
        }

        session.completionHandler?(nil, nil, URLError(.notConnectedToInternet))
        waitForExpectations(timeout: 1, handler: nil)

        XCTAssertEqual(error as? HTTPError, .noInternet)
    }

    func test_fetchBreedsList_timeout() {
        var error: Error?
        let exp = expectation(description: "Fetch breeds function completion block called")

        NetworkService.fetchBreedsList(client: client) { result in
            switch result {
            case .success:
                XCTFail("Expected an error to be thrown")
            case .failure(let returnedError):
                error = returnedError
                exp.fulfill()
            }
        }

        session.completionHandler?(nil, nil, URLError(.timedOut))
        waitForExpectations(timeout: 1, handler: nil)

        XCTAssertEqual(error as? HTTPError, .timedOut)
    }

    func test_fetchBreedsList_requestFailed() {
        var error: Error?
        let exp = expectation(description: "Fetch breeds function completion block called")

        NetworkService.fetchBreedsList(client: client) { result in
            switch result {
            case .success:
                XCTFail("Expected an error to be thrown")
            case .failure(let returnedError):
                error = returnedError
                exp.fulfill()
            }
        }

        session.completionHandler?(nil, nil, URLError(.badURL))
        waitForExpectations(timeout: 1, handler: nil)

        XCTAssertEqual(error as? URLRequestError, .requestFailed)
    }

    func test_fetchBreedsList_decodingError() {
        var error: Error?
        let exp = expectation(description: "Fetch breeds function completion block called")

        NetworkService.fetchBreedsList(client: client) { result in
            switch result {
            case .success:
                XCTFail("Expected an error to be thrown")
            case .failure(let returnedError):
                error = returnedError
                exp.fulfill()
            }
        }

        let response = MockURLSession.successResponse()
        session.completionHandler?("[foo]".data(using: .utf8), response, nil)
        waitForExpectations(timeout: 3, handler: nil)

        XCTAssertTrue(error is DecodingError)
    }
}
