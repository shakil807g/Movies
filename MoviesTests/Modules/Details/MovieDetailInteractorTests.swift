//
//  MovieDetailInteractorTests.swift
//  MoviesTests
//
//  Created by Khurram on 04/05/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import XCTest
@testable import Movies

final class MovieDetailInteractorTests: XCTestCase {
private let movie = Movie(poster: "", id: 0, backdrop: "", title: "", overview: "", releaseDate: nil, category: .popular)
private var sut: MovieDetailInteractor!
  
override func setUpWithError() throws {
  sut = MovieDetailInteractor(movie: movie, moviesService: MockService())
}
  
func testGetMovie() {
  let exp = defaultExpectation()
  sut.getMovie { result in
    exp.fulfill()
  }
  wait(for: [exp], timeout: 1)
}
func testGetImage() {
  let exp = defaultExpectation()
  sut.loadMovieImage(movie: movie) { result in
    switch result {
    case .failure(let error):
      XCTAssert(true, "\(error)")
    case .success:
      exp.fulfill()
    }
  }
  wait(for: [exp], timeout: 1)
}
}
