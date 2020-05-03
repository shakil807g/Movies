//
//  MovieDetailInteractor.swift
//  Movies
//
//  Created by Khurram on 03/05/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation

final class MovieDetailInteractor {
private let movie: Movie
init(movie: Movie) {
  self.movie = movie
}
}

extension MovieDetailInteractor: MovieDetailInteractorInput {
func getMovie(completion: @escaping(Movie)->Void) {
  DispatchQueue.main.async {
    completion(self.movie)
  }
}
}
