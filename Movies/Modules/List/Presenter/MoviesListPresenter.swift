//
//  MoviesListPresenter.swift
//  Movies
//
//  Created by Khurram on 02/05/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation

final class MoviesListPresenter {
  
private let dispatchGroup = DispatchGroup()
private let interactorInput: MoviesListInteractorInput
private let routerInput: MoviesListRouterInput
private var moviesSections = [MovieSection]()
private weak var viewInput: MoviesListViewInput?
  
init(interactorInput: MoviesListInteractorInput, routerInput: MoviesListRouterInput, viewInput: MoviesListViewInput?) {
  self.interactorInput = interactorInput
  self.routerInput = routerInput
  self.viewInput = viewInput
}
  
}

extension MoviesListPresenter: MoviesListViewOutput {
func loadMovieImage(movie: Movie, completion: @escaping (Data?) -> Void) {
  interactorInput.loadMovieImage(movie: movie) { result in
    switch result {
    case .failure(let error):
      if let userMessage = handleError(error) {
        self.viewInput?.showErrorMessage(errorMessage: userMessage)
      }
      completion(nil)
    case .success(let data):
      completion(data)
    }
  }
}
func didTriggerViewReadyEvent() {
  viewInput?.setupInitialState()
  loadMovies()
}

func didSelectMovie(movie: Movie) {
  routerInput.showMovieDetails(movie: movie)
}
} //extension MoviesListPresenter

extension MoviesListPresenter {
private func loadMovies() {
  viewInput?.showLoading(show: true)
  loadConfiguration()
  loadPopularMovies()
  loadTopRatedMovies()
  loadUpComingMovies()
  dispatchGroup.notify(queue: .main) {
    self.moviesSections.sort()
    self.notifyViewMoviesLoaded()
  }
}
private func loadConfiguration() {
  dispatchGroup.enter()
  interactorInput.loadConfiguration { [weak self] _ in
    self?.dispatchGroup.leave()
  }
}
private func loadPopularMovies(){
  dispatchGroup.enter()
  interactorInput.loadPopularMovies { [weak self] result in
    defer { self?.dispatchGroup.leave() }
    guard let self = self else { return }
    switch result {
    case .failure(let error):
      if let userMessage = handleError(error) {
        self.viewInput?.showErrorMessage(errorMessage: userMessage)
      }
    case .success(let movies):
      self.moviesSections.append(MovieSection(sectionName: NSLocalizedString("Popular", comment: "Popular"), movies: movies))
    }
  }
}
private func loadTopRatedMovies(){
  dispatchGroup.enter()
  interactorInput.loadTopRatedMovies { [weak self] result in
    defer { self?.dispatchGroup.leave() }
    guard let self = self else { return }
    switch result {
    case .failure(let error):
      if let userMessage = handleError(error) {
        self.viewInput?.showErrorMessage(errorMessage: userMessage)
      }
    case .success(let movies):
      self.moviesSections.append(MovieSection(sectionName: NSLocalizedString("Top Rated", comment: "Top Rated"), movies: movies))
    }
  }
}
private func loadUpComingMovies(){
  dispatchGroup.enter()
  interactorInput.loadUpComingMovies { [weak self] result in
    defer { self?.dispatchGroup.leave() }
    guard let self = self else { return }
    switch result {
    case .failure(let error):
      if let userMessage = handleError(error) {
        self.viewInput?.showErrorMessage(errorMessage: userMessage)
      }
    case .success(let movies):
      self.moviesSections.append(MovieSection(sectionName: NSLocalizedString("Up Coming", comment: "Up Coming"), movies: movies))
    }
  }
}
private func notifyViewMoviesLoaded() {
  viewInput?.showLoading(show: false)
  viewInput?.showMovies(moviesSections: moviesSections)
}
}
