//
//  MovieEntity+Movie.swift
//  Movies
//
//  Created by Khurram on 03/05/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import CoreData
import Foundation

extension MovieEntity {
func update(with movie: Movie) {
  poster = movie.poster
  id = Int32(movie.id)
  backdrop = movie.backdrop
  title = movie.title
  overview = movie.overview
  releaseDate = movie.releaseDate
  category = movie.category.rawValue
}
func toMovie() -> Movie {
  Movie(poster: poster ?? "", id: Int(id), backdrop: backdrop ?? "", title: title ?? "", overview: overview ?? "", releaseDate: releaseDate ?? nil, category: Category(rawValue: category) ?? .popular)
}
}
