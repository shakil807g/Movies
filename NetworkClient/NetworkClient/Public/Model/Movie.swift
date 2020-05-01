//
//  Movie.swift
//  NetworkClient
//
//  Created by Khurram on 28/04/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation

public struct Movie {
public let popularity: Float
public let voteCount: Int
public let poster: String?
public let id: Int
public let adult: Bool
public let backdrop: String?
public let title: String
public let averageVote: Float
public let overview: String
public let releaseDate: Date?
}

extension Movie: Decodable {
enum CodingKeys: String, CodingKey {
  case popularity
  case voteCount = "vote_count"
  case poster = "poster_path"
  case id
  case adult
  case backdrop = "backdrop_path"
  case title
  case averageVote = "vote_average"
  case overview
  case releaseDate = "release_date"
}
public init(from decoder: Decoder) throws {
  
  let values = try decoder.container(keyedBy: CodingKeys.self)
  popularity = try values.decode(Float.self, forKey: .popularity)
  voteCount = try values.decode(Int.self, forKey: .voteCount)
  poster = try values.decodeIfPresent(String.self, forKey: .poster)
  id = try values.decode(Int.self, forKey: .id)
  adult = try values.decode(Bool.self, forKey: .adult)
  backdrop = try values.decodeIfPresent(String.self, forKey: .backdrop)
  title = try values.decode(String.self, forKey: .title)
  averageVote = try values.decode(Float.self, forKey: .averageVote)
  overview = try values.decode(String.self, forKey: .overview)
  let releaseDateString = try values.decode(String.self, forKey: .releaseDate)
  releaseDate = DateFormatter.defaultFormatter.date(from: releaseDateString)
}
}
