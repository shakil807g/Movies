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
func toMovie() -> Movie {
  Movie(popularity: popularity,
        voteCount: voteCount,
        poster: poster,
        id: id,
        adult: adult,
        backdrop: backdrop,
        title: title,
        averageVote: averageVote,
        overview: overview,
        releaseDate: releaseDate)
}
}

extension Movie {
func toMovieItem() -> MovieItem {
  MovieItem(popularity: popularity, voteCount: voteCount, poster: poster, id: id, adult: adult, backdrop: backdrop, title: title, averageVote: averageVote, overview: overview, releaseDate: releaseDate)
}
}
