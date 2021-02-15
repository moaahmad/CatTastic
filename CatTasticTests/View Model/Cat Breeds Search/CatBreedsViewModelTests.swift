//
//  CatBreedsViewModelTests.swift
//  CatTasticTests
//
//  Created by Mohammed Ahmad on 8/2/21.
//
import XCTest
@testable import CatTastic

final class CatBreedsViewModelTests: XCTestCase {
    var sut: CatBreedsViewModel!
    var client: NetworkClient!
    var session: MockURLSession!

    override func setUp() {
        super.setUp()
        client = NetworkClient()
        session = MockURLSession()
        client.session = session
        sut = CatBreedsViewModel(client: client, dataSource: nil)
    }

    override func tearDown() {
        sut = nil
        client = nil
        super.tearDown()
    }

    func test_fetchCatBreeds_isSuccessful() {
        sut.fetchCatBreeds { result in
            switch result {
            case .success(let data):
                XCTAssertNotNil(data)
            case .failure:
                XCTFail("No error should be present")
            }
        }
    }
}
