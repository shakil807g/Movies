//
//  MovieDetailViewControllerTests.swift
//  MoviesTests
//
//  Created by Khurram on 04/05/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import XCTest
@testable import Movies

final class MockMovieDetailViewOutput: MovieDetailViewOutput {
  
private let expectation: XCTestExpectation
  
init(expectation: XCTestExpectation) {
  self.expectation = expectation
}
func didTriggerViewReadyEvent() {
  expectation.fulfill()
}

func loadMovieImage(movie: Movie, completion: @escaping (Data?) -> Void) {
  expectation.fulfill()
}
} // class MockMovieDetailViewOutput

final class MovieDetailViewControllerTests: XCTestCase {
  
private var movieDetailViewOutput: MockMovieDetailViewOutput!

func testViewReadyEventFire() {
  let exp = defaultExpectation()
  let sut = MovieDetailViewController()
  movieDetailViewOutput = MockMovieDetailViewOutput(expectation: exp)
  sut.movieDetailViewOutput = movieDetailViewOutput
  sut.viewDidLoad()
  wait(for: [exp], timeout: 1)
}
//func testLoadMovieImageEventFire() {
//  let exp = defaultExpectation()
//  let sut = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "movieDetailViewController") as! MovieDetailViewController
//  movieDetailViewOutput = MockMovieDetailViewOutput(expectation: exp)
//  sut.movieDetailViewOutput = movieDetailViewOutput
//  let movie = Movie(poster: "", id: 0, backdrop: "", title: "", overview: "", releaseDate: nil, category: .popular)
//  sut.showMovie(movie: movie)
//  wait(for: [exp], timeout: 1)
//}

}
