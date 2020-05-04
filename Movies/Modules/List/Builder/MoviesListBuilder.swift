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
    let moviesViewController = navigationController.viewControllers.first as? MoviesViewController,
    let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
    return nil
  }
  let router = MoviesListRouter(navigationController: navigationController)
  let networkInteractor = NetworkInteractor(moviesService: getService())
  let persistenceInteractor = PersistenceInteractor(persistence: CoreDataPersistence(persistentContainer: appDelegate.persistentContainer))
  let presenter = MoviesListPresenter(networkInteractorInput: networkInteractor, persistenceInteractorInput: persistenceInteractor, routerInput: router, viewInput: moviesViewController)
  moviesViewController.moviesListViewOutput = presenter
  return navigationController
}
}
