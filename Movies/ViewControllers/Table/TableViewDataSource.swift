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
  
init(listViewModelLoadingOutput: ListViewModelLoadingOutput) {
  super.init()
  subscribe(listViewModelLoadingOutput: listViewModelLoadingOutput)
}
  
func numberOfSections(in tableView: UITableView) -> Int {
  moviesSections.count
}
  
func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
  moviesSections[section].movies.count
}
  
func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
  let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath)
  if let movieCell = cell as? MovieTableViewCell {
    configure(movieCell: movieCell, movie: moviesSections[indexPath.section].movies[indexPath.row])
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
private func configure(movieCell: MovieTableViewCell, movie: Movie) {
  
}
}
