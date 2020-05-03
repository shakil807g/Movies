//
//  MovieDetailBuilder.swift
//  Movies
//
//  Created by Khurram on 03/05/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import UIKit
import Foundation

final class MovieDetailBuilder {
func build(movie: Movie) -> UIViewController? {
  let storyboard = UIStoryboard(name: "Main", bundle: nil)
  guard let detailViewController = storyboard.instantiateViewController(identifier: "movieDetailViewController") as? MovieDetailViewController else {
    return nil
  }
  let interactor = MovieDetailInteractor(movie: movie)
  let presenter = MovieDetailPresenter(interactorInput: interactor)
  detailViewController.movieDetailViewOutput = presenter
  presenter.movieDetailInput = detailViewController
  return detailViewController
}
}
