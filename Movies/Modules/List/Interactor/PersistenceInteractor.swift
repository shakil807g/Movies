//
//  PersistenceInteractor.swift
//  Movies
//
//  Created by Khurram on 04/05/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation

final class PersistenceInteractor {
  
private let persistence: Persistence
  
init(persistence: Persistence) {
  self.persistence = persistence
}
  
}

extension PersistenceInteractor: PersistenceInteractorInput {
func persist(movies: [Movie]) {
  persistence.persist(movies: movies)
}

func search(query: String, comepletion: @escaping ([Movie]) -> Void) {
  persistence.search(query: query, comepletion: comepletion)
}
}
