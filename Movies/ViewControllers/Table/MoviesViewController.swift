//
//  MoviesViewController.swift
//  Movies
//
//  Created by Khurram on 28/04/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Combine
import UIKit

final class MoviesViewController: UIViewController {

@IBOutlet weak var tableView: UITableView!
var viewModel: ListViewModelProvider?
var tableViewDelegate: UITableViewDelegate?
var tableViewDataSource: UITableViewDataSource?
  private var cancellables = Set<AnyCancellable>()
  
override func viewDidLoad() {
  super.viewDidLoad()
  configureTableView()
  loadMovies()
}
private func loadMovies() {
  viewModel?.loadMovies()
}
  
private func configureTableView() {
  tableView.delegate = tableViewDelegate
  tableView.dataSource = tableViewDataSource
  viewModel?.moviesSections.sink { _ in
    self.tableView.reloadData()
  }.store(in: &cancellables)
}
  
} // class ViewController
