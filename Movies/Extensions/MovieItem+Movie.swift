//
//  MovieItem+Movie.swift
//  Movies
//
//  Created by Khurram on 02/05/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import NetworkClient
import Foundation

extension MovieItem {
  func toMovie(with category: Category) -> Movie {
  Movie(poster: poster,
        id: id,
        backdrop: backdrop,
        title: title,
        overview: overview,
        releaseDate: releaseDate,
        category: category)
}
}

extension Movie {
func toMovieItem() -> MovieItem {
  MovieItem(poster: poster, id: id, backdrop: backdrop, title: title, overview: overview, releaseDate: releaseDate)
}
}
