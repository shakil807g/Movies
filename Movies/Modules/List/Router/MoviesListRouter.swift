//
//  MoviesListRouter.swift
//  Movies
//
//  Created by Khurram on 02/05/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import UIKit
import Foundation

final class MoviesListRouter {
  
weak var navigationController: UINavigationController?
init(navigationController: UINavigationController) {
  self.navigationController = navigationController
}
}
extension MoviesListRouter: MoviesListRouterInput {
func showMovieDetails(movie: Movie) {
  guard let navigationController = navigationController,
    let detailViewController = MovieDetailBuilder().build(movie: movie) else { return }
  navigationController.pushViewController(detailViewController, animated: true)
}
}
