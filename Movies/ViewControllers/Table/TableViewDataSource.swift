//
//  TableViewDataSource.swift
//  Movies
//
//  Created by Khurram on 01/05/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Combine
import Foundation
import UIKit

final class TableViewDataSource: NSObject, UITableViewDataSource {
  
private var cancelables = Set<AnyCancellable>()
private var moviesSections = [MovieSection]()
private let dateFormatter: DateFormatter = {
  let formatter = DateFormatter()
  formatter.dateFormat = "MMM yyyy"
  return formatter
}()
private weak var listViewModelInput: ListViewModelInput?
private weak var tableView: UITableView?
  
init(listViewModelLoadingOutput: ListViewModelLoadingOutput, listViewModelInput: ListViewModelInput) {
  super.init()
  self.listViewModelInput = listViewModelInput
  subscribe(listViewModelLoadingOutput: listViewModelLoadingOutput)
}
  
func numberOfSections(in tableView: UITableView) -> Int {
  if self.tableView == nil {
    self.tableView = tableView
  }
  return moviesSections.count
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
  
private func subscribe(listViewModelLoadingOutput: ListViewModelLoadingOutput) {
  listViewModelLoadingOutput.moviesSections.sink { moviesSections in
    self.moviesSections = moviesSections
  }.store(in: &cancelables)
}
private func configure(movieCell: MovieTableViewCell, movie: Movie, indexPath: IndexPath) {
  movieCell.nameLabel.text = movie.title
  if let releaseDate = movie.releaseDate {
    movieCell.dateLabel.text = dateFormatter.string(from: releaseDate)
  }
  listViewModelInput?.loadMovieImage(movie: movie) { data in
    guard let data = data,
      let image = UIImage(data: data),
      self.tableView?.indexPath(for: movieCell) == indexPath else { return }
    movieCell.bannerImageView.image = image
  }
}
}
