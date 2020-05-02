//
//  Router.swift
//  NetworkClient
//
//  Created by Khurram on 29/04/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation

enum Router {
case getConfiguration
case getPopular
case getTopRated
case getUpComing
}
//https://api.themoviedb.org/3/configuration?api_key=52d78a6d4567271b1e33f4b97134ee11
//https://api.themoviedb.org/3/movie/popular?api_key=52d78a6d4567271b1e33f4b97134ee11&language=en-US&page=1
//https://api.themoviedb.org/3/movie/top_rated?api_key=52d78a6d4567271b1e33f4b97134ee11&language=en-US&page=1
//https://api.themoviedb.org/3/movie/upcoming?api_key=52d78a6d4567271b1e33f4b97134ee11&language=en-US&page=1
private let baseUrlString = "https://api.themoviedb.org/3/"
private let apiKey = "52d78a6d4567271b1e33f4b97134ee11"
extension Router {
private var path: String {
  switch self {
  case .getConfiguration:
    return "configuration"
  case .getPopular:
    return "movie/popular"
  case .getTopRated:
    return "movie/top_rated"
  case .getUpComing:
    return "movie/upcoming"
  }
}
func urlRequest() throws -> URLRequest {
  guard
    let initialUrl = URL(string: baseUrlString)?.appendingPathComponent(path),
    var components = URLComponents(url: initialUrl, resolvingAgainstBaseURL: false) else {
      throw NetworkClientError.urlCreationFailed
  }
  var queryItems = [URLQueryItem(name: "api_key", value: apiKey),]
  switch self {
  case .getPopular, .getTopRated, .getUpComing:
    queryItems.append(contentsOf: [
      // We will use default english language
      URLQueryItem(name: "language", value: "en-US"),
      // We will use default only first page
      URLQueryItem(name: "page", value: "1")
    ])
  case .getConfiguration:
    break
  }
  components.queryItems = queryItems
  guard
    let url = components.url else {
      throw NetworkClientError.urlCreationFailed
  }
  return URLRequest(url: url)
}
}
