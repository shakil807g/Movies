//
//  MovieDetailPresenterTests.swift
//  MoviesTests
//
//  Created by Khurram on 04/05/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import XCTest
@testable import Movies

final class MockMovieDetailInteractorInput: MovieDetailInteractorInput {
  
private let returnValidImageData: Bool
  
init(returnValidImageData: Bool) {
  self.returnValidImageData = returnValidImageData
}
func getMovie(completion: @escaping (Movie) -> Void) {
  DispatchQueue.main.async {
    let movie = Movie(poster: "", id: 0, backdrop: "", title: "", overview: "", releaseDate: nil, category: .popular)
    completion(movie)
  }
}

func loadMovieImage(movie: Movie, completion: @escaping (Result<Data, Error>) -> Void) {
  DispatchQueue.main.async {
    if self.returnValidImageData {
      completion(.success(Data()))
    } else {
      completion(.failure(NSError(domain: "", code: 0, userInfo: nil)))
    }
  }
}
}

final class MockMovieDetailViewInput: MovieDetailViewInput {
private let expectation: XCTestExpectation
init(expectation: XCTestExpectation) {
  self.expectation = expectation
}
func showMovie(movie: Movie) {
  expectation.fulfill()
}

func showErrorMessage(errorMessage: String) {
  
}
}

final class MovieDetailPresenterTests: XCTestCase {

private var mockViewInput: MockMovieDetailViewInput!
  
func testGetMovie() {
  let exp = defaultExpectation()
  mockViewInput = MockMovieDetailViewInput(expectation: exp)
  let sut = MovieDetailPresenter(interactorInput: MockMovieDetailInteractorInput(returnValidImageData: true))
  sut.movieDetailInput = mockViewInput
  sut.didTriggerViewReadyEvent()
  wait(for: [exp], timeout: 1)
}
func testLoadMovieImage() {
  let exp = defaultExpectation()
  let sut = MovieDetailPresenter(interactorInput: MockMovieDetailInteractorInput(returnValidImageData: true))
  let movie = Movie(poster: "", id: 0, backdrop: "", title: "", overview: "", releaseDate: nil, category: .popular)
  sut.loadMovieImage(movie: movie) { data in
    if data != nil {
      exp.fulfill()
    }
  }
  wait(for: [exp], timeout: 1)
}
func testLoadMovieImageError() {
  let exp = defaultExpectation()
  let sut = MovieDetailPresenter(interactorInput: MockMovieDetailInteractorInput(returnValidImageData: false))
  let movie = Movie(poster: "", id: 0, backdrop: "", title: "", overview: "", releaseDate: nil, category: .popular)
  sut.loadMovieImage(movie: movie) { data in
    if data == nil {
      exp.fulfill()
    }
  }
  wait(for: [exp], timeout: 1)
}
}
