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
func resolve(for viewController: MoviesViewController, selectionDelegate: SelectionDelegate?) {
  let viewModel: ListViewModelProvider = ListViewModel(moviesService: getService())
  viewController.viewModel = viewModel
  let delegate = TableViewDelegate(listViewModelLoadingOutput: viewModel, selectionDelegate: selectionDelegate)
  let dataSource = TableViewDataSource(listViewModelLoadingOutput: viewModel, listViewModelInput: viewModel)
  viewController.tableViewDelegate = delegate
  viewController.tableViewDataSource = dataSource
}
}
