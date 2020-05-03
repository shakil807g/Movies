//
//  MovieDetailPresenter.swift
//  Movies
//
//  Created by Khurram on 03/05/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation

final class MovieDetailPresenter {
  
private let interactorInput: MovieDetailInteractorInput
weak var movieDetailInput: MovieDetailViewInput?
  
init(interactorInput: MovieDetailInteractorInput) {
  self.interactorInput = interactorInput
}
}

extension MovieDetailPresenter: MovieDetailViewOutput {
func didTriggerViewReadyEvent() {
  interactorInput.getMovie { movie in
    self.movieDetailInput?.showMovie(movie: movie)
  }
}
}
