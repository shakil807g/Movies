//
//  MovieDetailBuilderTests.swift
//  MoviesTests
//
//  Created by Khurram on 04/05/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import XCTest
@testable import Movies

final class MovieDetailBuilderTests: XCTestCase {

func testBuilder() {
  let builder = MovieDetailBuilder()
  let movie = Movie(poster: "", id: 0, backdrop: "", title: "", overview: "", releaseDate: nil, category: .popular)
  XCTAssertNotNil(builder.build(movie: movie))
}

}
