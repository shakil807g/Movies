//
//  ConfigurationTests.swift
//  NetworkClientTests
//
//  Created by Khurram on 04/05/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import XCTest
@testable import NetworkClient
final class ConfigurationTests: XCTestCase {
func testGetImageURL() {
  let jsonParser = JsonParser()
  do {
    let configuation: Configuration = try jsonParser.parse(configurationData)
    let movie: MoviesResponse = try jsonParser.parse(movieResponseData)
    let url = configuation.getImageURL(movie: movie.results[0])
    XCTAssertNotNil(url)
  } catch {
    XCTAssert(false, "\(error)")
  }
}
} // class ConfigurationTests
