//
//  MovieDetailInteractor.swift
//  Movies
//
//  Created by Khurram on 03/05/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import NetworkClient
import Foundation

final class MovieDetailInteractor {
  
private let movie: Movie
private let moviesService: MoviesService
  
init(movie: Movie, moviesService: MoviesService) {
  self.movie = movie
  self.moviesService = moviesService
}
}

extension MovieDetailInteractor: MovieDetailInteractorInput {
func getMovie(completion: @escaping(Movie)->Void) {
  DispatchQueue.main.async {
    completion(self.movie)
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
