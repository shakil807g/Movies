//
//  ImagesConfiguration.swift
//  NetworkClient
//
//  Created by Khurram on 02/05/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation

struct ImagesConfiguration: Decodable {
let secureBaseUrl: String
let backdropSizes: [String]
let posterSizes: [String]
  
enum CodingKeys: String, CodingKey {
  case secureBaseUrl = "secure_base_url"
  case backdropSizes = "backdrop_sizes"
  case posterSizes = "poster_sizes"
}
  
init(from decoder: Decoder) throws {
  let values = try decoder.container(keyedBy: CodingKeys.self)
  secureBaseUrl = try values.decode(String.self, forKey: .secureBaseUrl)
  backdropSizes = try values.decode([String].self, forKey: .backdropSizes)
  posterSizes = try values.decode([String].self, forKey: .posterSizes)
}
  
}
