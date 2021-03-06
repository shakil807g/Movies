//
//  MovieDetailViewOutput.swift
//  Movies
//
//  Created by Khurram on 03/05/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation

protocol MovieDetailViewOutput {
func didTriggerViewReadyEvent()
func loadMovieImage(movie: Movie, completion: @escaping(Data?) -> Void)
}
