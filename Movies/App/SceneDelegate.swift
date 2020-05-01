//
//  SceneDelegate.swift
//  Movies
//
//  Created by Khurram on 28/04/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {

var window: UIWindow?
private var appNavigation: NavigationProvider?
private let dependencyManager: DependencyProvider = DependencyManager()

func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
  configureFirstScreen()
}
private func configureFirstScreen() {
  guard
    let navigationController = window?.rootViewController as? UINavigationController,
    let moviesViewController = navigationController.viewControllers.first as? MoviesViewController else { return }
  let navigation = AppNavigation(navigationController: navigationController)
  appNavigation = navigation
  dependencyManager.resolve(for: moviesViewController, selectionDelegate: navigation)
}
} // class SceneDelegate
