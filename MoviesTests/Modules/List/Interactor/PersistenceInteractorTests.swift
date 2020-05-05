//
//  PersistenceInteractorTests.swift
//  MoviesTests
//
//  Created by Khurram on 04/05/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import XCTest
@testable import Movies

final class MockPersistence: Persistence {
  
private let expectation: XCTestExpectation
init(expectation: XCTestExpectation) {
  self.expectation = expectation
}
func persist(movies: [Movie]) {
  DispatchQueue.main.async {
    self.expectation.fulfill()
  }
}

func search(query: String, comepletion: @escaping ([Movie]) -> Void) {
  DispatchQueue.main.async {
    let movie = Movie(poster: "", id: 0, backdrop: "", title: "", overview: "", releaseDate: nil, category: .popular)
    comepletion([movie])
  }
}
}

final class PersistenceInteractorTests: XCTestCase {

func testPersist() {
  let exp = defaultExpectation()
  let sut = PersistenceInteractor(persistence: MockPersistence(expectation: exp))
  let movie = Movie(poster: "", id: 0, backdrop: "", title: "", overview: "", releaseDate: nil, category: .popular)
  sut.persist(movies: [movie])
  wait(for: [exp], timeout: 1)
}
func testSearch() {
  let exp = defaultExpectation()
  let sut = PersistenceInteractor(persistence: MockPersistence(expectation: exp))
  sut.search(query: "") { movies in
    exp.fulfill()
  }
  wait(for: [exp], timeout: 1)
}
} // class PersistenceInteractorTests
