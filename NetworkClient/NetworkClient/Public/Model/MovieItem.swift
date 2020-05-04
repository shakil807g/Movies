//
//  MovieItem.swift
//  NetworkClient
//
//  Created by Khurram on 28/04/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation

public struct MovieItem {
public let poster: String?
public let id: Int
public let backdrop: String?
public let title: String
public let overview: String
public let releaseDate: Date?
public init(poster: String?, id: Int, backdrop: String?, title: String, overview: String, releaseDate: Date?) {
  self.poster = poster
  self.id = id
  self.backdrop = backdrop
  self.title = title
  self.overview = overview
  self.releaseDate = releaseDate
}
}

extension MovieItem: Decodable {
enum CodingKeys: String, CodingKey {
  case poster = "poster_path"
  case id
  case backdrop = "backdrop_path"
  case title
  case overview
  case releaseDate = "release_date"
}
public init(from decoder: Decoder) throws {
  
  let values = try decoder.container(keyedBy: CodingKeys.self)
  poster = try values.decodeIfPresent(String.self, forKey: .poster)
  id = try values.decode(Int.self, forKey: .id)
  backdrop = try values.decodeIfPresent(String.self, forKey: .backdrop)
  title = try values.decode(String.self, forKey: .title)
  overview = try values.decode(String.self, forKey: .overview)
  let releaseDateString = try values.decode(String.self, forKey: .releaseDate)
  releaseDate = DateFormatter.defaultFormatter.date(from: releaseDateString)
}
}
