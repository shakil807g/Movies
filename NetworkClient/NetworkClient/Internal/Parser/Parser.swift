//
//  Parser.swift
//  NetworkClient
//
//  Created by Khurram on 29/04/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation

protocol Parser {
func parse(_ data: Data) throws -> MoviesResponse
}
