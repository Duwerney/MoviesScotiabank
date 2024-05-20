//
//  MoviesViewModelTest.swift
//  MovieScotiabankTests
//
//  Created by user on 19/05/24.
//

import XCTest
@testable import MovieScotiabank

class MoviesViewModelTests: XCTestCase {

    var viewModel: MoviesViewModel!

    override func setUp() {
        super.setUp()
        viewModel = MoviesViewModel()
    }

    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }

    func testInitialValues() {
        XCTAssertEqual(viewModel.searchQuery, "")
        XCTAssertTrue(viewModel.filteredPopularMovies.isEmpty)
        XCTAssertTrue(viewModel.filteredTopMovies.isEmpty)
        XCTAssertFalse(viewModel.showAlert)
    }

    func testFetchMovies() {
        viewModel.popularMovies = [
            Movie(id: 0, title: "Godzilla", overview: "Following", voteAverage: 7.0, voteCount: 9, posterPath: "", adult: false, originalLanguage: "en"),
            Movie(id: 0, title: "Kingdown", overview: "Several", voteAverage: 7.0, voteCount: 9, posterPath: "", adult: false, originalLanguage: "en"),
        ]
        viewModel.topMovies = [
            Movie(id: 0, title: "The", overview: "Spanni", voteAverage: 7.0, voteCount: 9, posterPath: "", adult: false, originalLanguage: "en")
        ]
        
        
        viewModel.adultFilter = true
        viewModel.languageFilter = "en"
        viewModel.voteAverage = "7.0"
        
        viewModel.filterMovies()
        
        
        
        XCTAssertEqual(viewModel.filteredPopularMovies.count, 2)
        XCTAssertEqual(viewModel.filteredTopMovies.count, 1)
        XCTAssertEqual(viewModel.filteredPopularMovies.first?.title, "Godzilla")
        XCTAssertEqual(viewModel.filteredTopMovies.first?.title, "The")
    }

    func testSearchMovies() {
        viewModel.searchQuery = "Black Lotus"
        viewModel.searchMovies(query: viewModel.searchQuery)
        XCTAssertFalse(viewModel.popularMovies.contains { $0.title.contains("Black Lotus") })
    }

    func testShowAlert() {
        viewModel.showAlert = true
        viewModel.alertMessage = "Error"
        XCTAssertTrue(viewModel.showAlert)
        XCTAssertEqual(viewModel.alertMessage, "Error")
    }
}
