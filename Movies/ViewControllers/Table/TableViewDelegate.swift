//
//  TableViewDelegate.swift
//  Movies
//
//  Created by Khurram on 01/05/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Combine
import Foundation
import UIKit

final class TableViewDelegate: NSObject, UITableViewDelegate {
  
private var cancelables = Set<AnyCancellable>()
private var moviesSections = [MovieSection]()
private weak var selectionDelegate: SelectionDelegate?
  
init(listViewModelLoadingOutput: ListViewModelLoadingOutput, selectionDelegate: SelectionDelegate?) {
  self.selectionDelegate = selectionDelegate
  super.init()
  subscribe(listViewModelLoadingOutput: listViewModelLoadingOutput)
}
  
func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
  selectionDelegate?.didSelect(movie: moviesSections[indexPath.section].movies[indexPath.row])
  tableView.deselectRow(at: indexPath, animated: true)
}
  
private func subscribe(listViewModelLoadingOutput: ListViewModelLoadingOutput) {
  listViewModelLoadingOutput.moviesSections.sink { moviesSections in
    self.moviesSections = moviesSections
  }.store(in: &cancelables)
}
}
