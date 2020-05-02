//
//  ListViewModel.swift
//  Movies
//
//  Created by Khurram on 30/04/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import NetworkClient
import Combine
import Foundation

final class ListViewModel: ListViewModelProvider {
  
private let moviesService: MoviesService
private let moviesSectionsSubject = PassthroughSubject<[MovieSection], Never>()
private let errorMessageSubject = PassthroughSubject<String, Never>()
private let dispatchGroup = DispatchGroup()
private var moviesSectionsArray = [MovieSection]()
  
var moviesSections: AnyPublisher<[MovieSection], Never>  {
  moviesSectionsSubject.eraseToAnyPublisher()
}
var errorMessage: AnyPublisher<String, Never> {
  errorMessageSubject.eraseToAnyPublisher()
}
  
init(moviesService: MoviesService) {
  self.moviesService = moviesService
}
func loadMovies() {
  getPopular()
  getTopRated()
  getUpComing()
  dispatchGroup.notify(queue: .main) {
    self.moviesSectionsArray.sort()
    self.moviesSectionsSubject.send(self.moviesSectionsArray)
  }
}
private func getPopular() {
  dispatchGroup.enter()
  moviesService.getPopular { [weak self] result in
    guard let self = self else { return }
    defer { self.dispatchGroup.leave() }
    switch result {
    case .failure(let error):
      self.onError(error: error)
    case .success(let movies):
      self.moviesSectionsArray.append(MovieSection(sectionName: "Popular", movies: movies.map { $0.toMovie() }))
    }
  }
}
private func getTopRated() {
  dispatchGroup.enter()
  moviesService.getTopRated { [weak self] result in
    guard let self = self else { return }
    defer { self.dispatchGroup.leave() }
    switch result {
    case .failure(let error):
      self.onError(error: error)
    case .success(let movies):
      self.moviesSectionsArray.append(MovieSection(sectionName: "Top Rated", movies: movies.map { $0.toMovie() }))
    }
  }
}
private func getUpComing() {
  dispatchGroup.enter()
  moviesService.getUpComing { [weak self] result in
    guard let self = self else { return }
    defer { self.dispatchGroup.leave() }
    switch result {
    case .failure(let error):
      self.onError(error: error)
    case .success(let movies):
      self.moviesSectionsArray.append(MovieSection(sectionName: "Up Coming", movies: movies.map { $0.toMovie() }))
    }
  }
}
private func onError(error: Error) {
  if let userMessage = handleError(error) {
    self.errorMessageSubject.send(userMessage)
  }
}
}
