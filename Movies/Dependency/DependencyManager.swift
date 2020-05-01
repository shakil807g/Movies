//
//  DependencyManager.swift
//  Movies
//
//  Created by Khurram on 30/04/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import NetworkClient
import Foundation

final class DependencyManager: DependencyProvider {
func resolve(for viewController: MoviesViewController) {
  let viewModel: ListViewModelProvider = ListViewModel(moviesService: getService())
  viewController.viewModel = viewModel
  let delegate = TableViewDelegate(listViewModelLoadingOutput: viewModel)
  let dataSource = TableViewDataSource(listViewModelLoadingOutput: viewModel)
  viewController.tableViewDelegate = delegate
  viewController.tableViewDataSource = dataSource
}
}
