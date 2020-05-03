//
//  MovieDetailViewController.swift
//  Movies
//
//  Created by Khurram on 03/05/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import UIKit

final class MovieDetailViewController: UIViewController {

var movieDetailViewOutput: MovieDetailViewOutput?
  
override func viewDidLoad() {
  super.viewDidLoad()
  movieDetailViewOutput?.didTriggerViewReadyEvent()
}

}

extension MovieDetailViewController: MovieDetailViewInput {
func showMovie(movie: Movie) {
  print(movie)
}
}
