//
//  MoviesListPresenterTests.swift
//  MoviesTests
//
//  Created by Khurram on 05/05/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import XCTest
@testable import Movies

final class MockNetworkInteractorInput: NetworkInteractorInput {
  
var assertConfiguration = false
var assertPopularMovies = false
var assertTopRatedMovies = false
var assertUpComingMovies = false
var assertImage = false
  
var callConfigurationCompletion = false
var callPopularMoviesCompletion = false
var callTopRatedMoviesCompletion = false
var callUpComingMoviesCompletion = false
  
var returnPopularMoviesError = false
  
private let movies = [Movie(poster: "", id: 0, backdrop: "", title: "", overview: "", releaseDate: nil, category: .popular)]
  
func loadConfiguration(completion: @escaping (Result<Void, Error>) -> Void) {
  if assertConfiguration {
    XCTAssert(true)
  }
  if callConfigurationCompletion {
    DispatchQueue.main.async {
      completion(.success(()))
    }
  }
}

func loadPopularMovies(completion: @escaping (Result<[Movie], Error>) -> Void) {
  if assertPopularMovies {
    XCTAssert(true)
  }
  if callPopularMoviesCompletion {
    DispatchQueue.main.async {
      if self.returnPopularMoviesError {
        completion(.failure(NSError(domain: "", code: 0, userInfo: nil)))
      } else {
        completion(.success(self.movies))
      }
    }
  }
}

func loadTopRatedMovies(completion: @escaping (Result<[Movie], Error>) -> Void) {
  if assertTopRatedMovies {
    XCTAssert(true)
  }
  if callTopRatedMoviesCompletion {
    DispatchQueue.main.async {
      completion(.success(self.movies))
    }
  }
}

func loadUpComingMovies(completion: @escaping (Result<[Movie], Error>) -> Void) {
  if assertUpComingMovies {
    XCTAssert(true)
  }
  if callUpComingMoviesCompletion {
    DispatchQueue.main.async {
      completion(.success(self.movies))
    }
  }
}

func loadMovieImage(movie: Movie, completion: @escaping (Result<Data, Error>) -> Void) {
  if assertImage {
    XCTAssert(true)
  }
}
} // class MockNetworkInteractorInput

final class MockPersistenceInteractorInput: PersistenceInteractorInput {
  
var assertPersist = false

var expectation: XCTestExpectation?
  
func persist(movies: [Movie]) {
  if assertPersist {
    expectation?.fulfill()
  }
}

func search(query: String, comepletion: @escaping ([Movie]) -> Void) {
  
}
} // class MockPersistenceInteractorInput

final class MockMoviesListRouterInput: MoviesListRouterInput {
  
var assertShowMovieDetails = false
  
func showMovieDetails(movie: Movie) {
  if assertShowMovieDetails {
    XCTAssert(true)
  }
}
}

final class MockMoviesListViewInput: MoviesListViewInput {
  
var assertShowLoading = false
var assertSetupInitialState = false
var assertShowMovies = false
var assertShowError = false
  
var expectation: XCTestExpectation?
  
func setupInitialState() {
  if assertSetupInitialState {
    XCTAssert(true)
  }
}

func showMovies(moviesSections: [MovieSection]) {
  if assertShowMovies {
    expectation?.fulfill()
  }
}

func showLoading(show: Bool) {
  if assertShowLoading {
    XCTAssert(true)
  }
}

func showErrorMessage(errorMessage: String) {
  if assertShowError {
    XCTAssert(true)
  }
}
} // class MockMoviesListViewInput

final class MoviesListPresenterTests: XCTestCase {

private var sut: MoviesListPresenter!
  
override func setUpWithError() throws {
  
}

override func tearDownWithError() throws {
  sut = nil
}
  
func testLoadConfigurationCalled() {
  let networkInteractor = MockNetworkInteractorInput()
  networkInteractor.assertConfiguration = true
  sut = MoviesListPresenter(networkInteractorInput: networkInteractor,
                            persistenceInteractorInput: MockPersistenceInteractorInput(),
                            routerInput: MockMoviesListRouterInput(),
                            viewInput: MockMoviesListViewInput())
  sut.didTriggerViewReadyEvent()
}
func testLoadPopularMoviesCalled() {
  let networkInteractor = MockNetworkInteractorInput()
  networkInteractor.assertPopularMovies = true
  sut = MoviesListPresenter(networkInteractorInput: networkInteractor,
                            persistenceInteractorInput: MockPersistenceInteractorInput(),
                            routerInput: MockMoviesListRouterInput(),
                            viewInput: MockMoviesListViewInput())
  sut.didTriggerViewReadyEvent()
}
func testLoadTopRatedMoviesCalled() {
  let networkInteractor = MockNetworkInteractorInput()
  networkInteractor.assertTopRatedMovies = true
  sut = MoviesListPresenter(networkInteractorInput: networkInteractor,
                            persistenceInteractorInput: MockPersistenceInteractorInput(),
                            routerInput: MockMoviesListRouterInput(),
                            viewInput: MockMoviesListViewInput())
  sut.didTriggerViewReadyEvent()
}
func testLoadUpComingMoviesCalled() {
  let networkInteractor = MockNetworkInteractorInput()
  networkInteractor.assertUpComingMovies = true
  sut = MoviesListPresenter(networkInteractorInput: networkInteractor,
                            persistenceInteractorInput: MockPersistenceInteractorInput(),
                            routerInput: MockMoviesListRouterInput(),
                            viewInput: MockMoviesListViewInput())
  sut.didTriggerViewReadyEvent()
}
func testLoadImageCalled() {
  let networkInteractor = MockNetworkInteractorInput()
  networkInteractor.assertImage = true
  sut = MoviesListPresenter(networkInteractorInput: networkInteractor,
                            persistenceInteractorInput: MockPersistenceInteractorInput(),
                            routerInput: MockMoviesListRouterInput(),
                            viewInput: MockMoviesListViewInput())
  let movie = Movie(poster: "", id: 0, backdrop: "", title: "", overview: "", releaseDate: nil, category: .popular)
  sut.loadMovieImage(movie: movie, completion: {_ in })
}
func testPopularMoviesPersistenceCalled() {
  let exp = defaultExpectation()
  let networkInteractor = MockNetworkInteractorInput()
  networkInteractor.callPopularMoviesCompletion = true
  
  let persistenceInteractor = MockPersistenceInteractorInput()
  persistenceInteractor.assertPersist = true
  persistenceInteractor.expectation = exp
  sut = MoviesListPresenter(networkInteractorInput: networkInteractor,
                            persistenceInteractorInput: persistenceInteractor,
                            routerInput: MockMoviesListRouterInput(),
                            viewInput: MockMoviesListViewInput())
  sut.didTriggerViewReadyEvent()
  wait(for: [exp], timeout: 1)
}
func testTopRatedMoviesPersistenceCalled() {
  let exp = defaultExpectation()
  let networkInteractor = MockNetworkInteractorInput()
  networkInteractor.callTopRatedMoviesCompletion = true
  
  let persistenceInteractor = MockPersistenceInteractorInput()
  persistenceInteractor.assertPersist = true
  persistenceInteractor.expectation = exp
  sut = MoviesListPresenter(networkInteractorInput: networkInteractor,
                            persistenceInteractorInput: persistenceInteractor,
                            routerInput: MockMoviesListRouterInput(),
                            viewInput: MockMoviesListViewInput())
  sut.didTriggerViewReadyEvent()
  wait(for: [exp], timeout: 1)
}
func testUpComingMoviesPersistenceCalled() {
  let exp = defaultExpectation()
  let networkInteractor = MockNetworkInteractorInput()
  networkInteractor.callUpComingMoviesCompletion = true
  
  let persistenceInteractor = MockPersistenceInteractorInput()
  persistenceInteractor.assertPersist = true
  persistenceInteractor.expectation = exp
  sut = MoviesListPresenter(networkInteractorInput: networkInteractor,
                            persistenceInteractorInput: persistenceInteractor,
                            routerInput: MockMoviesListRouterInput(),
                            viewInput: MockMoviesListViewInput())
  sut.didTriggerViewReadyEvent()
  wait(for: [exp], timeout: 1)
}
func testShowMoviesDetailsCalled() {
  let routerInput = MockMoviesListRouterInput()
  routerInput.assertShowMovieDetails = true
  sut = MoviesListPresenter(networkInteractorInput: MockNetworkInteractorInput(),
                            persistenceInteractorInput: MockPersistenceInteractorInput(),
                            routerInput: routerInput,
                            viewInput: MockMoviesListViewInput())
  let movie = Movie(poster: "", id: 0, backdrop: "", title: "", overview: "", releaseDate: nil, category: .popular)
  sut.didSelectMovie(movie: movie)
}
func testShowInititalStateCalled() {
  let viewInput = MockMoviesListViewInput()
  viewInput.assertSetupInitialState = true
  sut = MoviesListPresenter(networkInteractorInput: MockNetworkInteractorInput(),
                            persistenceInteractorInput: MockPersistenceInteractorInput(),
                            routerInput: MockMoviesListRouterInput(),
                            viewInput: viewInput)
  sut.didTriggerViewReadyEvent()
}
func testShowMoviesCalled() {
  
  let exp = defaultExpectation()
  
  let viewInput = MockMoviesListViewInput()
  viewInput.assertShowMovies = true
  viewInput.expectation = exp
  
  let networkInteractor = MockNetworkInteractorInput()
  networkInteractor.callConfigurationCompletion = true
  networkInteractor.callPopularMoviesCompletion = true
  networkInteractor.callTopRatedMoviesCompletion = true
  networkInteractor.callUpComingMoviesCompletion = true
  
  sut = MoviesListPresenter(networkInteractorInput: networkInteractor,
                            persistenceInteractorInput: MockPersistenceInteractorInput(),
                            routerInput: MockMoviesListRouterInput(),
                            viewInput: viewInput)
  sut.didTriggerViewReadyEvent()
  wait(for: [exp], timeout: 2)
}
func testShowLoadingCalled() {
  let viewInput = MockMoviesListViewInput()
  viewInput.assertShowLoading = true
  
  sut = MoviesListPresenter(networkInteractorInput: MockNetworkInteractorInput(),
                            persistenceInteractorInput: MockPersistenceInteractorInput(),
                            routerInput: MockMoviesListRouterInput(),
                            viewInput: viewInput)
  sut.didTriggerViewReadyEvent()
}
func testShowErrorMessageCalled() {
  let viewInput = MockMoviesListViewInput()
  viewInput.assertShowError = true
  
  let networkInteractor = MockNetworkInteractorInput()
  networkInteractor.callPopularMoviesCompletion = true
  networkInteractor.returnPopularMoviesError = true
  sut = MoviesListPresenter(networkInteractorInput: MockNetworkInteractorInput(),
                            persistenceInteractorInput: MockPersistenceInteractorInput(),
                            routerInput: MockMoviesListRouterInput(),
                            viewInput: viewInput)
  sut.didTriggerViewReadyEvent()
}
}
