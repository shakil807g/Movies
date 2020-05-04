//
//  JsonParserTests.swift
//  NetworkClientTests
//
//  Created by Khurram on 30/04/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import XCTest
@testable import NetworkClient

final class JsonParserTests: XCTestCase {

func testParseMoviesResponse() {
  let sut = JsonParser()
  do {
    let moviesResponse: MoviesResponse = try sut.parse(movieResponseData)
    XCTAssertTrue(!moviesResponse.results.isEmpty)
    let movie = moviesResponse.results.first!
    XCTAssertNotNil(movie.poster)
    XCTAssertTrue(!movie.poster!.isEmpty)
    XCTAssert(movie.id == 419704)
    XCTAssertNotNil(movie.backdrop)
    XCTAssertTrue(!movie.backdrop!.isEmpty)
    XCTAssert(movie.title == "Ad Astra")
    XCTAssert(!movie.overview.isEmpty)
  } catch {
    XCTAssert(false, "\(error)")
  }
}
func testParseConfiguration() {
  let sut = JsonParser()
  do {
    let configuration: Configuration = try sut.parse(configurationData)
    XCTAssert(!configuration.images.backdropSizes.isEmpty)
    XCTAssert(!configuration.images.backdropSizes[0].isEmpty)
    XCTAssert(!configuration.images.posterSizes.isEmpty)
    XCTAssert(!configuration.images.posterSizes[0].isEmpty)
    XCTAssert(!configuration.images.secureBaseUrl.isEmpty)
  } catch {
    XCTAssert(false, "\(error)")
  }
}
} // class JsonParserTests
