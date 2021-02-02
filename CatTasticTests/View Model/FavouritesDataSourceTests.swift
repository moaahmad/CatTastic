//
//  FavouritesDataSourceTests.swift
//  CatTasticTests
//
import XCTest
@testable import CatTastic

final class FavouritesDataSourceTests: XCTestCase {
    var dataSource: FavouritesDataSource!

    override func setUp() {
        super.setUp()
        dataSource = FavouritesDataSource()
    }

    override func tearDown() {
        dataSource = nil
        super.tearDown()
    }

    func testEmptyValueInDataSource() {
        // Arrange
        dataSource.data.value = []
        let tableView = UITableView()
        tableView.dataSource = dataSource
        // Assert
        XCTAssertEqual(dataSource.numberOfSections(in: tableView), 1, "Expected one section")
        XCTAssertEqual(dataSource.tableView(tableView, numberOfRowsInSection: 0), 0, "Expected no cell")
    }

    func testValueInDataSource() {
        // Arrange
        let cat1 = createCat(name: "Cat 1", origin: "North Pole")
        let cat2 = createCat(name: "Cat 2", origin: "South Pole")
        dataSource.data.value = [cat1, cat2]
        let tableView = UITableView()
        tableView.dataSource = dataSource
        // Assert
        XCTAssertEqual(dataSource.numberOfSections(in: tableView), 1, "Expected one section")
        XCTAssertEqual(dataSource.tableView(tableView, numberOfRowsInSection: 0), 2, "Expected two cells")
    }
}

// MARK: - Helpers
extension FavouritesDataSourceTests {
    func createCat(name: String, origin: String) -> CatBreed {
        CatBreed(id: "",
                 name: name,
                 description: nil,
                 temperament: nil,
                 lifeSpan: nil,
                 alternativeNames: nil,
                 wikipediaURL: nil,
                 origin: origin,
                 weight: nil,
                 image: Image(id: nil, url: nil, categories: nil, breeds: nil)
        )
    }
}
