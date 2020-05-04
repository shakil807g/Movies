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

func testParse() throws {
  let data = """
{
    "page": 1,
    "total_results": 10000,
    "total_pages": 500,
    "results": [
        {
            "popularity": 511.945,
            "vote_count": 3150,
            "video": false,
            "poster_path": "/xBHvZcjRiWyobQ9kxBhO6B2dtRI.jpg",
            "id": 419704,
            "adult": false,
            "backdrop_path": "/5BwqwxMEjeFtdknRV792Svo0K1v.jpg",
            "original_language": "en",
            "original_title": "Ad Astra",
            "genre_ids": [
                18,
                878
            ],
            "title": "Ad Astra",
            "vote_average": 6,
            "overview": "The near future, a time when both hope and hardships drive humanity to look to the stars and beyond. While a mysterious phenomenon menaces to destroy life on planet Earth, astronaut Roy McBride undertakes a mission across the immensity of space and its many perils to uncover the truth about a lost expedition that decades before boldly faced emptiness and silence in search of the unknown.",
            "release_date": "2019-09-17"
        }
    ]
}
""".data(using: .utf8)!
  
  let sut = JsonParser()
  let moviesResponse: MoviesResponse = try sut.parse(data)
  XCTAssertTrue(!moviesResponse.results.isEmpty)
  let movie = moviesResponse.results.first!
  XCTAssertNotNil(movie.poster)
  XCTAssertTrue(!movie.poster!.isEmpty)
  XCTAssert(movie.id == 419704)
  XCTAssertNotNil(movie.backdrop)
  XCTAssertTrue(!movie.backdrop!.isEmpty)
  XCTAssert(movie.title == "Ad Astra")
  XCTAssert(!movie.overview.isEmpty)
}

}
