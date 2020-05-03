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

func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
  guard let windowScene = scene as? UIWindowScene else { return }
  window = UIWindow(windowScene: windowScene)
  configureFirstScreen()
}
private func configureFirstScreen() {
  window?.rootViewController = MoviesListBuilder().build()
  window?.makeKeyAndVisible()
}
} // class SceneDelegate
