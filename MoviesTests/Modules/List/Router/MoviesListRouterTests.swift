//
//  MoviesListRouterTests.swift
//  MoviesTests
//
//  Created by Khurram on 05/05/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import XCTest
@testable import Movies

final class MoviesListRouterTests: XCTestCase {

func testShowMovieDetails() throws {
  let navigationController = UINavigationController()
  let sut = MoviesListRouter(navigationController: navigationController)
  let movie = Movie(poster: "", id: 0, backdrop: "", title: "", overview: "", releaseDate: nil, category: .popular)
  sut.showMovieDetails(movie: movie)
  XCTAssert(navigationController.viewControllers.count == 1)
}

}
