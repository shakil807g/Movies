//
//  RestMoviesService.swift
//  NetworkClient
//
//  Created by Khurram on 28/04/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation

final class MoviesRestService: MoviesService {
  
private let session: URLSessionProtocol
private let parser: Parser
private var tasks = [URLSessionDataTaskProtocol]()
  
init(session: URLSessionProtocol, parser: Parser) {
  self.session = session
  self.parser = parser
}
  
func getPopular(completion: @escaping (Result<[MovieItem], Error>) -> Void) {
  perform(router: Router.getPopular, completion: completion)
}
func getTopRated(completion: @escaping(Result<[MovieItem], Error>) -> Void) {
  perform(router: Router.getTopRated, completion: completion)
}
func getUpComing(completion: @escaping(Result<[MovieItem], Error>) -> Void) {
  perform(router: Router.getUpComing, completion: completion)
}
private func perform(router: Router, completion: @escaping(Result<[MovieItem], Error>) -> Void) {
  do {
    let request = try router.urlRequest()
    perform(request: request, completion: completion)
  } catch {
    DispatchQueue.main.async {
      completion(.failure(error))
    }
  }
}
private func perform(request: URLRequest, completion: @escaping (Result<[MovieItem], Error>) -> Void) {
  let task = session.dataTask(with: request) { [weak self] data, response, error in
    guard let self = self else { return }
    if let error = error {
      DispatchQueue.main.async {
        completion(.failure(error))
      }
      return
    }
    guard let data = data else {
      DispatchQueue.main.async {
        completion(.failure(NetworkClientError.noData))
      }
      return
    }
    let result: Result<[MovieItem], Error>
    do {
      let moviesResponse = try self.parser.parse(data)
      result = .success(moviesResponse.results)
    } catch {
      result = .failure(error)
    }
    DispatchQueue.main.async {
      completion(result)
    }
  }
  task.resume()
  tasks.append(task)
}
  
} // class MoviesRestService
