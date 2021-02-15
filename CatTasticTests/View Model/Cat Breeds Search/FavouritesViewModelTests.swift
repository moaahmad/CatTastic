//
//  FavouritesViewModelTests.swift
//  CatTasticTests
//
//  Created by Mohammed Ahmad on 8/2/21.
//
import XCTest
@testable import CatTastic

final class FavouritesViewModelTests: XCTestCase {

    var sut: FavouritesViewModel!
    var persistenceManager: MockPersistenceManager!

    override func setUp() {
        super.setUp()
        persistenceManager = MockPersistenceManager()
        sut = FavouritesViewModel(dataSource: nil, persistence: persistenceManager)
    }

    override func tearDown() {
        sut = nil
        persistenceManager = nil
        super.tearDown()
    }

    func test_retrieveFavourites_isSuccessful() {
        persistenceManager.retrievalResult = .success([])
        sut.fetchFavourites { error in
            XCTAssertNil(error)
        }
    }

    func test_retrieveFavourites_unableToFavourite() {
        persistenceManager.retrievalResult = .failure(.unableToFavourite)
        sut.fetchFavourites { error in
            XCTAssertEqual(error, PersistenceError.unableToFavourite)
        }
    }
}
