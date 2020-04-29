//
//  MoviesResponse.swift
//  NetworkClient
//
//  Created by Khurram on 29/04/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation

struct MoviesResponse: Decodable {
let results: [Movie]
}
