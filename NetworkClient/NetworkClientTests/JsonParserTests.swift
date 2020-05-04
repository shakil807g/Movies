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
  do {
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
  } catch {
    XCTAssert(false, "\(error)")
  }
}
func testParseConfiguration() {
  let data =
"""
{
    "images": {
        "base_url": "http://image.tmdb.org/t/p/",
        "secure_base_url": "https://image.tmdb.org/t/p/",
        "backdrop_sizes": [
            "w300",
            "w780",
            "w1280",
            "original"
        ],
        "logo_sizes": [
            "w45",
            "w92",
            "w154",
            "w185",
            "w300",
            "w500",
            "original"
        ],
        "poster_sizes": [
            "w92",
            "w154",
            "w185",
            "w342",
            "w500",
            "w780",
            "original"
        ],
        "profile_sizes": [
            "w45",
            "w185",
            "h632",
            "original"
        ],
        "still_sizes": [
            "w92",
            "w185",
            "w300",
            "original"
        ]
    }
}
""".data(using: .utf8)!
  
  let sut = JsonParser()
  do {
    let configuration: Configuration = try sut.parse(data)
    XCTAssert(!configuration.images.backdropSizes.isEmpty)
    XCTAssert(!configuration.images.backdropSizes[0].isEmpty)
    XCTAssert(!configuration.images.posterSizes.isEmpty)
    XCTAssert(!configuration.images.posterSizes[0].isEmpty)
    XCTAssert(!configuration.images.secureBaseUrl.isEmpty)
  } catch {
    XCTAssert(false, "\(error)")
  }
  
}

}
