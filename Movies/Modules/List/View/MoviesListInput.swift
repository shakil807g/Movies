//
//  MoviesListInput.swift
//  Movies
//
//  Created by Khurram on 02/05/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation

protocol MoviesListViewInput: class {
func setupInitialState()
func showMovies(moviesSections: [MovieSection])
func showLoading(show: Bool)
}
