//
//  MoviesListInteractor.swift
//  Movies
//
//  Created by Khurram on 02/05/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import NetworkClient
import Foundation

final class NetworkInteractor {
  
private let moviesService: MoviesService
  
init(moviesService: MoviesService) {
  self.moviesService = moviesService
}
  
}

extension NetworkInteractor: NetworkInteractorInput {
func loadConfiguration(completion: @escaping (Result<Void, Error>) -> Void) {
  moviesService.getConfiguration(completion: completion)
}
  
func loadPopularMovies(completion: @escaping(Result<[Movie], Error>) -> Void) {
  moviesService.getPopular { result in
    switch result {
    case .failure(let error):
      completion(.failure(error))
    case .success(let movies):
      completion(.success(movies.map { $0.toMovie(with: .popular) }))
    }
  }
}

func loadTopRatedMovies(completion: @escaping(Result<[Movie], Error>) -> Void) {
  moviesService.getTopRated { result in
    switch result {
    case .failure(let error):
      completion(.failure(error))
    case .success(let movies):
      completion(.success(movies.map { $0.toMovie(with: .topRated) }))
    }
  }
}

func loadUpComingMovies(completion: @escaping(Result<[Movie], Error>) -> Void) {
  moviesService.getUpComing { result in
    switch result {
    case .failure(let error):
      completion(.failure(error))
    case .success(let movies):
      completion(.success(movies.map { $0.toMovie(with: .upComing) }))
    }
  }
}
func loadMovieImage(movie: Movie, completion: @escaping(Result<Data, Error>) -> Void) {
  moviesService.getImageData(for: movie.toMovieItem()) { result in
    switch result {
    case .failure(let error):
      DispatchQueue.main.async {
        completion(.failure(error))
      }
    case .success(let data):
      completion(.success(data))
    }
  }
}
}
