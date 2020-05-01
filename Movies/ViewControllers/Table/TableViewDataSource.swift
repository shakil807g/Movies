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
private var moviesSection = [MovieSection]()
  
init(listViewModelLoadingOutput: ListViewModelLoadingOutput) {
  super.init()
  subscribe(listViewModelLoadingOutput: listViewModelLoadingOutput)
}
  
func numberOfSections(in tableView: UITableView) -> Int {
  moviesSection.count
}
  
func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
  moviesSection[section].movies.count
}
  
func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
  let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath)
  cell.textLabel?.text = moviesSection[indexPath.section].movies[indexPath.row].title
  return cell
}
  
func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
  moviesSection[section].sectionName
}
  
private func subscribe(listViewModelLoadingOutput: ListViewModelLoadingOutput) {
  listViewModelLoadingOutput.moviesSections.sink { movieSection in
    self.moviesSection.append(movieSection)
  }.store(in: &cancelables)
}
  
}
