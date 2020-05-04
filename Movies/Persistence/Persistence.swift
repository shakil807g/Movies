//
//  Persistence.swift
//  Movies
//
//  Created by Khurram on 03/05/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation

protocol Persistence {
func persist(movies: [Movie])
func search(query: String, comepletion: @escaping([Movie]) -> Void)
}
