//
//  MovieDetailInteractorInput.swift
//  Movies
//
//  Created by Khurram on 03/05/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation

protocol MovieDetailInteractorInput {
func getMovie(completion: @escaping(Movie)->Void)
func loadMovieImage(movie: Movie, completion: @escaping(Result<Data, Error>) -> Void)
}
