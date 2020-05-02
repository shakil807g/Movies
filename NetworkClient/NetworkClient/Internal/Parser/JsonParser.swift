//
//  File.swift
//  NetworkClient
//
//  Created by Khurram on 29/04/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation

final class JsonParser: Parser {
  
func parse<T: Decodable>(_ data: Data) throws -> T {
  try JSONDecoder().decode(T.self, from: data)
}
}
