//
//  DependencyProvider.swift
//  Movies
//
//  Created by Khurram on 30/04/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation

protocol DependencyProvider {
func resolve(for viewController: MoviesViewController, selectionDelegate: SelectionDelegate?)
}
