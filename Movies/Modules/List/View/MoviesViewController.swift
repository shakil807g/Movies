//
//  MoviesViewController.swift
//  Movies
//
//  Created by Khurram on 28/04/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import UIKit

final class MoviesViewController: UIViewController {

@IBOutlet weak var tableView: UITableView!
var moviesListViewOutput: MoviesListViewOutput?
private var moviesSections = [MovieSection]()
private let searchController = UISearchController(searchResultsController: nil)
private let dateFormatter: DateFormatter = {
  let formatter = DateFormatter()
  formatter.dateFormat = "MMM yyyy"
  return formatter
}()
  
override func viewDidLoad() {
  super.viewDidLoad()
  moviesListViewOutput?.didTriggerViewReadyEvent()
}
  
} // class MoviesViewController

extension MoviesViewController: MoviesListViewInput {
func setupInitialState() {
  confirgureSearch()
}

func showMovies(moviesSections: [MovieSection]) {
  self.moviesSections = moviesSections
  tableView.reloadData()
}

func showLoading(show: Bool) {
  if show {
    let indicatorView = UIActivityIndicatorView(style: .large)
    indicatorView.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
    tableView.tableHeaderView = indicatorView
    indicatorView.startAnimating()
  } else {
    tableView.tableHeaderView = nil
  }
}
func showErrorMessage(errorMessage: String) {
  print(errorMessage)
}
private func confirgureSearch() {
  searchController.obscuresBackgroundDuringPresentation = false
  searchController.searchBar.placeholder = "Search Articles"
  navigationItem.searchController = searchController
  navigationItem.hidesSearchBarWhenScrolling = false
  searchController.searchBar.delegate = self
  definesPresentationContext = true
}
} // extension MoviesViewController

extension MoviesViewController: UITableViewDataSource {
func numberOfSections(in tableView: UITableView) -> Int {
  moviesSections.count
}
  
func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
  moviesSections[section].movies.count
}
  
func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
  let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath)
  if let movieCell = cell as? MovieTableViewCell {
    configure(movieCell: movieCell, movie: moviesSections[indexPath.section].movies[indexPath.row], indexPath: indexPath)
  }
  return cell
}
  
func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
  moviesSections[section].sectionName
}
private func configure(movieCell: MovieTableViewCell, movie: Movie, indexPath: IndexPath) {
  movieCell.nameLabel.text = movie.title
  if let releaseDate = movie.releaseDate {
    movieCell.dateLabel.text = dateFormatter.string(from: releaseDate)
  }
  moviesListViewOutput?.loadMovieImage(movie: movie) { data in
    guard let data = data,
      let image = UIImage(data: data) else { return }
    DispatchQueue.main.async {
      if self.tableView?.indexPath(for: movieCell) == indexPath {
        movieCell.bannerImageView.contentMode = .scaleAspectFill
        movieCell.bannerImageView.image = image
      }
    }
  }
}
} // extension MoviesViewController

extension MoviesViewController: UITableViewDelegate {
func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
  moviesListViewOutput?.didSelectMovie(movie: moviesSections[indexPath.section].movies[indexPath.row])
  tableView.deselectRow(at: indexPath, animated: true)
}
} // extension MoviesViewController

extension MoviesViewController: UISearchBarDelegate {
func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
  moviesListViewOutput?.search(query: searchBar.text!)
}
func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
  moviesListViewOutput?.searchDismissed()
}
}
