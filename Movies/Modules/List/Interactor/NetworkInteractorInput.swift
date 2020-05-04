//
//  MoviesListInteractorInput.swift
//  Movies
//
//  Created by Khurram on 02/05/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation

protocol NetworkInteractorInput: class {

func loadConfiguration(completion: @escaping(Result<Void, Error>) -> Void)
func loadPopularMovies(completion: @escaping(Result<[Movie], Error>) -> Void)
func loadTopRatedMovies(completion: @escaping(Result<[Movie], Error>) -> Void)
func loadUpComingMovies(completion: @escaping(Result<[Movie], Error>) -> Void)
func loadMovieImage(movie: Movie, completion: @escaping(Result<Data, Error>) -> Void)
}
