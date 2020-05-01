//
//  SelectionDelegate.swift
//  Movies
//
//  Created by Khurram on 01/05/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import NetworkClient
import Foundation

protocol SelectionDelegate: class {
func didSelect(movie: Movie)
}
