//
//  NetworkInteractorTests.swift
//  MoviesTests
//
//  Created by Khurram on 04/05/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import XCTest
@testable import Movies

final class NetworkInteractorTests: XCTestCase {
  
private let movie = Movie(poster: "", id: 0, backdrop: "", title: "", overview: "", releaseDate: nil, category: .popular)
private let mockService = MockService()
private var sut: NetworkInteractor!

override func setUpWithError() throws {
  sut = NetworkInteractor(moviesService: mockService)
}
  
func testLoadConfiguration() {
  let exp = defaultExpectation()
  mockService.returnConfigurationError = false
  sut.loadConfiguration { result in
    switch result {
    case .failure(let error):
      print(error)
    case .success:
      exp.fulfill()
    }
  }
  wait(for: [exp], timeout: 1)
}
func testLoadConfigurationError() {
  let exp = defaultExpectation()
  mockService.returnConfigurationError = true
  sut.loadConfiguration { result in
    switch result {
    case .failure:
      exp.fulfill()
    case .success:
      XCTAssert(false, "Should not be success")
    }
  }
  wait(for: [exp], timeout: 1)
}
func testLoadPopularMovies() {
  let exp = defaultExpectation()
  mockService.returnGetPopularMoviesError = false
  sut.loadPopularMovies { result in
    switch result {
    case .failure(let error):
      print(error)
    case .success:
      exp.fulfill()
    }
  }
  wait(for: [exp], timeout: 1)
}
func testLoadPopularMoviesError() {
  let exp = defaultExpectation()
  mockService.returnGetPopularMoviesError = true
  sut.loadPopularMovies { result in
    switch result {
    case .failure:
      exp.fulfill()
    case .success:
      XCTAssert(false, "Should not be success")
    }
  }
  wait(for: [exp], timeout: 1)
}
func testLoadTopRatedMovies() {
  let exp = defaultExpectation()
  mockService.returnGetTopRatedMoviesError = false
  sut.loadTopRatedMovies { result in
    switch result {
    case .failure(let error):
      print(error)
    case .success:
      exp.fulfill()
    }
  }
  wait(for: [exp], timeout: 1)
}
func testLoadTopRatedMoviesError() {
  let exp = defaultExpectation()
  mockService.returnGetTopRatedMoviesError = true
  sut.loadTopRatedMovies { result in
    switch result {
    case .failure:
      exp.fulfill()
    case .success:
      XCTAssert(false, "Should not be success")
    }
  }
  wait(for: [exp], timeout: 1)
}
func testLoadUpComingMovies() {
  let exp = defaultExpectation()
  mockService.returnGetUpComingMoviesError = false
  sut.loadUpComingMovies { result in
    switch result {
    case .failure(let error):
      print(error)
    case .success:
      exp.fulfill()
    }
  }
  wait(for: [exp], timeout: 1)
}
func testLoadUpComingMoviesError() {
  let exp = defaultExpectation()
  mockService.returnGetUpComingMoviesError = true
  sut.loadUpComingMovies { result in
    switch result {
    case .failure:
      exp.fulfill()
    case .success:
      XCTAssert(false, "Should not be success")
    }
  }
  wait(for: [exp], timeout: 1)
}
func testGetImage() {
  let exp = defaultExpectation()
  mockService.returnImageDataError = false
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
func testGetImageError() {
  let exp = defaultExpectation()
  mockService.returnImageDataError = true
  sut.loadMovieImage(movie: movie) { result in
    switch result {
    case .failure:
      exp.fulfill()
    case .success:
      XCTAssert(true, "Should not be success")
    }
  }
  wait(for: [exp], timeout: 1)
}
}
