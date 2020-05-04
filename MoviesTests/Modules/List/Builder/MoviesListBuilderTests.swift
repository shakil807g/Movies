//
//  MoviesListBuilderTests.swift
//  MoviesTests
//
//  Created by Khurram on 04/05/2020.
//  Copyright © 2020 Example. All rights reserved.
//

@testable import Movies

import XCTest

final class MoviesListBuilderTests: XCTestCase {

func testBuilder() {
  XCTAssertNotNil(MoviesListBuilder().build())
}
  
} // class MoviesListBuilderTests
