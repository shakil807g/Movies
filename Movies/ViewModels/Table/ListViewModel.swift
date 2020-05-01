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
private let moviesSectionsSubject = PassthroughSubject<MovieSection, Never>()
private let errorMessageSubject = PassthroughSubject<String, Never>()
  
var moviesSections: AnyPublisher<MovieSection, Never>  {
  moviesSectionsSubject.eraseToAnyPublisher()
}
var errorMessage: AnyPublisher<String, Never> {
  errorMessageSubject.eraseToAnyPublisher()
}
  
init(moviesService: MoviesService) {
  self.moviesService = moviesService
}
func loadMovies() {
  moviesService.getPopular { [weak self] result in
    guard let self = self else { return }
    switch result {
    case .failure(let error):
      if let userMessage = handleError(error) {
        self.errorMessageSubject.send(userMessage)
      }
    case .success(let movies):
      self.moviesSectionsSubject.send(MovieSection(sectionName: "Popular", movies: movies))
    }
  }
}
}
