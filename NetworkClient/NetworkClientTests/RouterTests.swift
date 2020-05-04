//
//  RouterTests.swift
//  NetworkClientTests
//
//  Created by Khurram on 04/05/2020.
//  Copyright © 2020 Example. All rights reserved.
//

@testable import NetworkClient
import XCTest

final class RouterTests: XCTestCase {

func testGetConfigurationRequest() {
  do {
    let request = try Router.getConfiguration.urlRequest()
    XCTAssertNotNil(request)
  } catch {
    XCTAssert(false, "\(error)")
  }
}
func testGetPopularMoviesRequest() {
  do {
    let request = try Router.getPopular.urlRequest()
    XCTAssertNotNil(request)
  } catch {
    XCTAssert(false, "\(error)")
  }
}
func testGetTopRatedMoviesRequest() {
  do {
    let request = try Router.getTopRated.urlRequest()
    XCTAssertNotNil(request)
  } catch {
    XCTAssert(false, "\(error)")
  }
}
func testGetUpComingMoviesRequest() {
  do {
    let request = try Router.getUpComing.urlRequest()
    XCTAssertNotNil(request)
  } catch {
    XCTAssert(false, "\(error)")
  }
}
} // class RouterTests
