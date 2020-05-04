//
//  RestMovieServiceTests.swift
//  NetworkClientTests
//
//  Created by Khurram on 04/05/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import XCTest
@testable import NetworkClient

final class MockURLSessionDataTask: URLSessionDataTaskProtocol {
  
private (set) var resumeWasCalled = false
  
func resume() {
  resumeWasCalled = true
}
} // class MockURLSessionDataTask

final class MockURLSession: URLSessionProtocol {
  
var nextDataTask = MockURLSessionDataTask()
var nextData: Data?
var nextError: Error?

private (set) var lastURL: URL?

func successHttpURLResponse(request: URLRequest) -> URLResponse {
  HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: "HTTP/1.1", headerFields: nil)!
}

func dataTask(with request: URLRequest, completionHandler: @escaping DataTaskResult) -> URLSessionDataTaskProtocol {
  lastURL = request.url
  
  completionHandler(nextData, successHttpURLResponse(request: request), nextError)
  return nextDataTask
}
  
} // class MockURLSession

final class RestMovieServiceTests: XCTestCase {

private let session = MockURLSession()
private var service: RestMoviesService!
  
override func setUpWithError() throws {
  service = RestMoviesService(session: session, parser: JsonParser())
}

override func tearDownWithError() throws {
  // Put teardown code here. This method is called after the invocation of each test method in the class.
}

func testGetConfiguration() {
  let exp = defaultExpectation()
  session.nextData = configurationData
  service.getConfiguration { result in
    switch result {
    case .failure(let error):
      XCTAssert(false, "\(error)")
    case .success:
      exp.fulfill()
    }
  }
  wait(for: [exp], timeout: 1)
}
func testGetConfigurationError() {
  let exp = defaultExpectation()
  session.nextData = nil
  session.nextError = NSError()
  service.getConfiguration { result in
    switch result {
    case .failure:
      exp.fulfill()
    case .success:
      XCTAssert(false, "Should not be success")
    }
  }
  wait(for: [exp], timeout: 1)
}
func testGetConfigurationNoData() {
  let exp = defaultExpectation()
  session.nextData = nil
  session.nextError = nil
  service.getConfiguration { result in
    switch result {
    case .failure:
      exp.fulfill()
    case .success:
      XCTAssert(false, "Should not be success")
    }
  }
  wait(for: [exp], timeout: 1)
}
func testGetConfigurationEmptyData() {
  let exp = defaultExpectation()
  session.nextData = Data()
  session.nextError = nil
  service.getConfiguration { result in
    switch result {
    case .failure:
      exp.fulfill()
    case .success:
      XCTAssert(false, "Should not be success")
    }
  }
  wait(for: [exp], timeout: 1)
}
func testGetPopularMovies() {
  let exp = defaultExpectation()
  session.nextData = movieResponseData
  service.getPopular { result in
    switch result {
    case .failure(let error):
      XCTAssert(false, "\(error)")
    case .success(let movies):
      XCTAssert(!movies.isEmpty)
      exp.fulfill()
    }
  }
  wait(for: [exp], timeout: 1)
}
func testGetPopularMoviesError() {
  let exp = defaultExpectation()
  session.nextData = nil
  session.nextError = NSError()
  service.getPopular { result in
    switch result {
    case .failure:
      exp.fulfill()
    case .success:
      XCTAssert(false, "Should not be success")
    }
  }
  wait(for: [exp], timeout: 1)
}
func testGetPopularMoviesNoData() {
  let exp = defaultExpectation()
  session.nextData = nil
  session.nextError = nil
  service.getPopular { result in
    switch result {
    case .failure:
      exp.fulfill()
    case .success:
      XCTAssert(false, "Should not be success")
    }
  }
  wait(for: [exp], timeout: 1)
}
func testGetPopularMoviesEmptyData() {
  let exp = defaultExpectation()
  session.nextData = Data()
  session.nextError = nil
  service.getPopular { result in
    switch result {
    case .failure:
      exp.fulfill()
    case .success:
      XCTAssert(false, "Should not be success")
    }
  }
  wait(for: [exp], timeout: 1)
}
func testGetTopRatedMovies() {
  let exp = defaultExpectation()
  session.nextData = movieResponseData
  service.getTopRated { result in
    switch result {
    case .failure(let error):
      XCTAssert(false, "\(error)")
    case .success(let movies):
      XCTAssert(!movies.isEmpty)
      exp.fulfill()
    }
  }
  wait(for: [exp], timeout: 1)
}
func testGetTopRatedMoviesError() {
  let exp = defaultExpectation()
  session.nextData = nil
  session.nextError = NSError()
  service.getTopRated { result in
    switch result {
    case .failure:
      exp.fulfill()
    case .success:
      XCTAssert(false, "Should not be success")
    }
  }
  wait(for: [exp], timeout: 1)
}
func testGetTopRatedMoviesNoData() {
  let exp = defaultExpectation()
  session.nextData = nil
  session.nextError = nil
  service.getTopRated { result in
    switch result {
    case .failure:
      exp.fulfill()
    case .success:
      XCTAssert(false, "Should not be success")
    }
  }
  wait(for: [exp], timeout: 1)
}
func testGetTopRatedMoviesEmptyData() {
  let exp = defaultExpectation()
  session.nextData = Data()
  session.nextError = nil
  service.getTopRated { result in
    switch result {
    case .failure:
      exp.fulfill()
    case .success:
      XCTAssert(false, "Should not be success")
    }
  }
  wait(for: [exp], timeout: 1)
}
func testGetUpComingMovies() {
  let exp = defaultExpectation()
  session.nextData = movieResponseData
  service.getUpComing { result in
    switch result {
    case .failure(let error):
      XCTAssert(false, "\(error)")
    case .success(let movies):
      XCTAssert(!movies.isEmpty)
      exp.fulfill()
    }
  }
  wait(for: [exp], timeout: 1)
}
func testGetUpComingMoviesError() {
  let exp = defaultExpectation()
  session.nextData = nil
  session.nextError = NSError()
  service.getUpComing { result in
    switch result {
    case .failure:
      exp.fulfill()
    case .success:
      XCTAssert(false, "Should not be success")
    }
  }
  wait(for: [exp], timeout: 1)
}
func testGetUpComingMoviesNoData() {
  let exp = defaultExpectation()
  session.nextData = nil
  session.nextError = nil
  service.getUpComing { result in
    switch result {
    case .failure:
      exp.fulfill()
    case .success:
      XCTAssert(false, "Should not be success")
    }
  }
  wait(for: [exp], timeout: 1)
}
func testGetUpComingMoviesEmptyData() {
  let exp = defaultExpectation()
  session.nextData = Data()
  session.nextError = nil
  service.getUpComing { result in
    switch result {
    case .failure:
      exp.fulfill()
    case .success:
      XCTAssert(false, "Should not be success")
    }
  }
  wait(for: [exp], timeout: 1)
}
func testGetImage() {
  let exp = defaultExpectation()
  session.nextData = configurationData
  service.getConfiguration { result in
    switch result {
    case .failure(let error):
      XCTAssert(false, "\(error)")
    case .success:
      self.session.nextData = Data()
      let jsonParser = JsonParser()
      do {
        let moviesResponse: MoviesResponse = try jsonParser.parse(movieResponseData)
        self.service.getImageData(for: moviesResponse.results[0]) { imageResult in
          switch imageResult {
          case .failure(let error):
            XCTAssert(false, "\(error)")
          case .success:
            exp.fulfill()
          }
        }
      } catch {
        XCTAssert(false, "\(error)")
      }
    }
  }
  wait(for: [exp], timeout: 1)
}
/// Configuration must first be loaded before requesting image
func testGetImageNoConfiguration() {
  let exp = defaultExpectation()
  session.nextError = nil
  session.nextData = nil
  let jsonParser = JsonParser()
  do {
    let moviesResponse: MoviesResponse = try jsonParser.parse(movieResponseData)
    service.getImageData(for: moviesResponse.results[0]) { result in
      switch result {
      case .failure:
        exp.fulfill()
      case .success:
        XCTAssert(false, "Should not be success")
      }
    }
  } catch {
    XCTAssert(false, "\(error)")
  }
  wait(for: [exp], timeout: 1)
}
func testGetImageError() {
  let exp = defaultExpectation()
  session.nextData = configurationData
  service.getConfiguration { result in
    switch result {
    case .failure(let error):
      XCTAssert(false, "\(error)")
    case .success:
      self.session.nextData = nil
      self.session.nextError = NSError()
      let jsonParser = JsonParser()
      do {
        let moviesResponse: MoviesResponse = try jsonParser.parse(movieResponseData)
        self.service.getImageData(for: moviesResponse.results[0]) { imageResult in
          switch imageResult {
          case .failure:
            exp.fulfill()
          case .success:
            XCTAssert(false, "Should not be success")
          }
        }
      } catch {
        XCTAssert(false, "\(error)")
      }
    }
  }
  wait(for: [exp], timeout: 1)
}
func testGetImageNoData() {
  let exp = defaultExpectation()
  session.nextData = configurationData
  service.getConfiguration { result in
    switch result {
    case .failure(let error):
      XCTAssert(false, "\(error)")
    case .success:
      self.session.nextData = nil
      self.session.nextError = nil
      let jsonParser = JsonParser()
      do {
        let moviesResponse: MoviesResponse = try jsonParser.parse(movieResponseData)
        self.service.getImageData(for: moviesResponse.results[0]) { imageResult in
          switch imageResult {
          case .failure:
            exp.fulfill()
          case .success:
            XCTAssert(false, "Should not be success")
          }
        }
      } catch {
        XCTAssert(false, "\(error)")
      }
    }
  }
  wait(for: [exp], timeout: 1)
}
}
