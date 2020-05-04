//
//  MoviesListViewOutput.swift
//  Movies
//
//  Created by Khurram on 02/05/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation

protocol MoviesListViewOutput: class {
func didTriggerViewReadyEvent()
func didSelectMovie(movie: Movie)
func loadMovieImage(movie: Movie, completion: @escaping(Data?) -> Void)
func search(query: String)
func searchDismissed()
}
