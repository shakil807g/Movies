//
//  AppNavigation.swift
//  Movies
//
//  Created by Khurram on 30/04/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import UIKit
import Foundation

final class AppNavigation: NavigationProvider, SelectionDelegate {

private weak var navigationController: UINavigationController?

init(navigationController: UINavigationController) {
  self.navigationController = navigationController
}
  
func didSelect(movie: Movie) {
  showMovieDetail(movie: movie)
}
func showMovieDetail(movie: Movie) {
  let movieDetailViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "movieDetailViewController")
  navigationController?.pushViewController(movieDetailViewController, animated: true)
}
  
}
