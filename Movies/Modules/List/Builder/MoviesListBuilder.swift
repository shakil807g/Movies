//
//  MoviesListBuilder.swift
//  Movies
//
//  Created by Khurram on 02/05/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import NetworkClient

import UIKit
import Foundation

final class MoviesListBuilder {
func build() -> UIViewController? {
  let storyboard = UIStoryboard(name: "Main", bundle: nil)
  guard
    let navigationController = storyboard.instantiateInitialViewController() as? UINavigationController,
    let moviesViewController = navigationController.viewControllers.first as? MoviesViewController else {
    return nil
  }
  let router = MoviesListRouter(navigationController: navigationController)
  let interactor = MoviesListInteractor(moviesService: getService())
  let presenter = MoviesListPresenter(interactorInput: interactor, routerInput: router, viewInput: moviesViewController)
  moviesViewController.moviesListViewOutput = presenter
  return navigationController
}
}
