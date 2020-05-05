//
//  MoviesViewControllerTests.swift
//  MoviesTests
//
//  Created by Khurram on 05/05/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import XCTest
@testable import Movies

final class MockMoviesListViewOutput: MoviesListViewOutput {
  
private let expectation: XCTestExpectation
  
init(expectation: XCTestExpectation) {
  self.expectation = expectation
}
  
func didTriggerViewReadyEvent() {
  expectation.fulfill()
}

func didSelectMovie(movie: Movie) {
  
}

func loadMovieImage(movie: Movie, completion: @escaping (Data?) -> Void) {
  
}

func search(query: String) {
  
}

func searchDismissed() {
  
}
}

final class MoviesViewControllerTests: XCTestCase {

func testViewReadyEventFire() {
  let exp = defaultExpectation()
  let navigationController = MoviesListBuilder().build() as! UINavigationController
  let sut = navigationController.viewControllers[0] as! MoviesViewController
  sut.moviesListViewOutput = MockMoviesListViewOutput(expectation: exp)
  sut.viewDidLoad()
  wait(for: [exp], timeout: 1)
}

}
