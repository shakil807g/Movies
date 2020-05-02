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
private let cache = NSCache<NSURL, NSData>()
private var tasks = [URLSessionDataTaskProtocol]()
private var configuration: Configuration?
  
init(session: URLSessionProtocol, parser: Parser) {
  self.session = session
  self.parser = parser
}
func getImageData(for movieItem: MovieItem, completion: @escaping(Result<Data, Error>) -> Void) {
  guard let url = configuration?.getImageURL(movie: movieItem) else {
    DispatchQueue.main.async {
      completion(.failure(NetworkClientError.urlCreationFailed))
    }
    return
  }
  if let data = cache.object(forKey: url as NSURL) {
    DispatchQueue.main.async {
      completion(.success(data as Data))
    }
    return
  }
  let task = session.dataTask(with: URLRequest(url: url)) { data, response, error in
    if let error = error {
      DispatchQueue.main.async {
        completion(.failure(error))
      }
    }
    guard let data = data else {
      DispatchQueue.main.async {
        completion(.failure(NetworkClientError.noData))
      }
      return
    }
    self.cache.setObject(data as NSData, forKey: url as NSURL)
    DispatchQueue.main.async {
      completion(.success(data))
    }
  }
  task.resume()
  tasks.append(task)
}
func getConfiguration(completion: @escaping(Result<Void, Error>) -> Void) {
  do {
    let request = try Router.getConfiguration.urlRequest()
    perform(request: request) { (result: Result<Configuration, Error>) in
      let configurationResult: Result<Void, Error>
      switch result {
      case .failure(let error):
        configurationResult = .failure(error)
      case .success(let configuration):
        configurationResult = .success(())
        self.configuration = configuration
      }
      DispatchQueue.main.async {
        completion(configurationResult)
      }
    }
  }
  catch {
    DispatchQueue.main.async {
      completion(.failure(error))
    }
  }
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
    perform(request: request) { (result: Result<MoviesResponse, Error>) in
      let moviesResult: Result<[MovieItem], Error>
      switch result {
      case .failure(let error):
        moviesResult = .failure(error)
      case .success(let moviesResponse):
        moviesResult = .success(moviesResponse.results)
      }
      DispatchQueue.main.async {
        completion(moviesResult)
      }
    }
  } catch {
    DispatchQueue.main.async {
      completion(.failure(error))
    }
  }
}
  private func perform<T: Decodable>(request: URLRequest, completion: @escaping (Result<T, Error>) -> Void) {
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
    let result: Result<T, Error>
    do {
      let decodedResponse: T = try self.parser.parse(data)
      result = .success(decodedResponse)
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
