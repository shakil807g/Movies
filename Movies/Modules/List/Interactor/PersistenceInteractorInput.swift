//
//  PersistenceInteractorInput.swift
//  Movies
//
//  Created by Khurram on 04/05/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation

protocol PersistenceInteractorInput {
func persist(movies: [Movie])
func search(query: String, comepletion: @escaping([Movie]) -> Void)
}
