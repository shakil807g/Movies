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
private let networkInteractorInput: NetworkInteractorInput
private let persistenceInteractorInput: PersistenceInteractorInput
private let routerInput: MoviesListRouterInput
private var moviesSections = [MovieSection]()
private weak var viewInput: MoviesListViewInput?
  
init(networkInteractorInput: NetworkInteractorInput, persistenceInteractorInput: PersistenceInteractorInput, routerInput: MoviesListRouterInput, viewInput: MoviesListViewInput?) {
  self.networkInteractorInput = networkInteractorInput
  self.persistenceInteractorInput = persistenceInteractorInput
  self.routerInput = routerInput
  self.viewInput = viewInput
}
  
}

extension MoviesListPresenter: MoviesListViewOutput {
func loadMovieImage(movie: Movie, completion: @escaping (Data?) -> Void) {
  networkInteractorInput.loadMovieImage(movie: movie) { result in
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
func search(query: String) {
  persistenceInteractorInput.search(query: query) { [weak self] movies in
    guard let self = self else { return }
    var searchedSections = [MovieSection]()
    let popularMovies = movies.filter { $0.category == .popular }
    let topRatedMovies = movies.filter { $0.category == .topRated }
    let upComingMovies = movies.filter { $0.category == .upComing }
    if !popularMovies.isEmpty {
      searchedSections.append(MovieSection(sectionName: NSLocalizedString("Popular", comment: "Popular"), movies: popularMovies))
    }
    if !topRatedMovies.isEmpty {
      searchedSections.append(MovieSection(sectionName: NSLocalizedString("Top Rated", comment: "Top Rated"), movies: topRatedMovies))
    }
    if !upComingMovies.isEmpty {
      searchedSections.append(MovieSection(sectionName: NSLocalizedString("Up Coming", comment: "Up Coming"), movies: upComingMovies))
    }
    searchedSections.sort()
    self.viewInput?.showMovies(moviesSections: searchedSections)
  }
}
func searchDismissed() {
  // show the movies loaded from network
  viewInput?.showMovies(moviesSections: moviesSections)
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
  networkInteractorInput.loadConfiguration { [weak self] _ in
    self?.dispatchGroup.leave()
  }
}
private func loadPopularMovies(){
  dispatchGroup.enter()
  networkInteractorInput.loadPopularMovies { [weak self] result in
    defer { self?.dispatchGroup.leave() }
    guard let self = self else { return }
    switch result {
    case .failure(let error):
      if let userMessage = handleError(error) {
        self.viewInput?.showErrorMessage(errorMessage: userMessage)
      }
    case .success(let movies):
      self.persistenceInteractorInput.persist(movies: movies)
      self.moviesSections.append(MovieSection(sectionName: NSLocalizedString("Popular", comment: "Popular"), movies: movies))
    }
  }
}
private func loadTopRatedMovies(){
  dispatchGroup.enter()
  networkInteractorInput.loadTopRatedMovies { [weak self] result in
    defer { self?.dispatchGroup.leave() }
    guard let self = self else { return }
    switch result {
    case .failure(let error):
      if let userMessage = handleError(error) {
        self.viewInput?.showErrorMessage(errorMessage: userMessage)
      }
    case .success(let movies):
      self.persistenceInteractorInput.persist(movies: movies)
      self.moviesSections.append(MovieSection(sectionName: NSLocalizedString("Top Rated", comment: "Top Rated"), movies: movies))
    }
  }
}
private func loadUpComingMovies(){
  dispatchGroup.enter()
  networkInteractorInput.loadUpComingMovies { [weak self] result in
    defer { self?.dispatchGroup.leave() }
    guard let self = self else { return }
    switch result {
    case .failure(let error):
      if let userMessage = handleError(error) {
        self.viewInput?.showErrorMessage(errorMessage: userMessage)
      }
    case .success(let movies):
      self.persistenceInteractorInput.persist(movies: movies)
      self.moviesSections.append(MovieSection(sectionName: NSLocalizedString("Up Coming", comment: "Up Coming"), movies: movies))
    }
  }
}
private func notifyViewMoviesLoaded() {
  viewInput?.showLoading(show: false)
  viewInput?.showMovies(moviesSections: moviesSections)
}
}
