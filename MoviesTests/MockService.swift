//
//  MockService.swift
//  MoviesTests
//
//  Created by Khurram on 04/05/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation
import NetworkClient
import Movies

final class MockService: MoviesService {
  
var returnConfigurationError = false
var returnGetPopularMoviesError = false
var returnGetTopRatedMoviesError = false
var returnGetUpComingMoviesError = false
var returnImageDataError = false
  
private let movies = [MovieItem(poster: "", id: 0, backdrop: "", title: "", overview: "", releaseDate: nil)]
  
func getConfiguration(completion: @escaping (Result<Void, Error>) -> Void) {
  DispatchQueue.main.async {
    if self.returnConfigurationError {
      completion(.failure(NSError()))
    } else {
      completion(.success(()))
    }
  }
}

func getPopular(completion: @escaping (Result<[MovieItem], Error>) -> Void) {
  DispatchQueue.main.async {
    if self.returnGetPopularMoviesError {
      completion(.failure(NSError()))
    } else {
      completion(.success(self.movies))
    }
  }
}

func getTopRated(completion: @escaping (Result<[MovieItem], Error>) -> Void) {
  DispatchQueue.main.async {
    if self.returnGetTopRatedMoviesError {
      completion(.failure(NSError()))
    } else {
      completion(.success(self.movies))
    }
  }
}

func getUpComing(completion: @escaping (Result<[MovieItem], Error>) -> Void) {
  DispatchQueue.main.async {
    if self.returnGetUpComingMoviesError {
      completion(.failure(NSError()))
    } else {
      completion(.success(self.movies))
    }
  }
}

func getImageData(for movieItem: MovieItem, completion: @escaping (Result<Data, Error>) -> Void) {
  DispatchQueue.main.async {
    if self.returnImageDataError {
      completion(.failure(NSError()))
    } else {
      completion(.success(Data()))
    }
  }
}
  
} // class MockService
