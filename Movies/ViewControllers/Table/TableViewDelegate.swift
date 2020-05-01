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
private var moviesSection = [MovieSection]()

init(listViewModelLoadingOutput: ListViewModelLoadingOutput) {
  super.init()
  subscribe(listViewModelLoadingOutput: listViewModelLoadingOutput)
}
private func subscribe(listViewModelLoadingOutput: ListViewModelLoadingOutput) {
  listViewModelLoadingOutput.moviesSections.sink { movieSection in
    self.moviesSection.append(movieSection)
  }.store(in: &cancelables)
}
}
