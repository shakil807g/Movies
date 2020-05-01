//
//  MovieSection.swift
//  Movies
//
//  Created by Khurram on 01/05/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import NetworkClient
import Foundation

final class MovieSection {
  
let sectionName: String
let movies: [Movie]
  
init(sectionName: String, movies: [Movie]) {
  self.sectionName = sectionName
  self.movies = movies
}
  
}

extension MovieSection: Comparable {
static func < (lhs: MovieSection, rhs: MovieSection) -> Bool {
  lhs.sectionName < rhs.sectionName
}

static func == (lhs: MovieSection, rhs: MovieSection) -> Bool {
  lhs.sectionName == rhs.sectionName
}
}
