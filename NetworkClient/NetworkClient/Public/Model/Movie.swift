//
//  Movie.swift
//  NetworkClient
//
//  Created by Khurram on 28/04/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation

public struct Movie {
let popularity: Float
let voteCount: Int
let poster: String?
let adult: Bool
let backdrop: String?
let title: String
let averageVote: Float
let overview: String
let releaseDate: Date?
}

extension Movie: Decodable {
enum CodingKeys: String, CodingKey {
  case popularity
  case voteCount = "vote_count"
  case poster = "poster_path"
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
  adult = try values.decode(Bool.self, forKey: .adult)
  backdrop = try values.decodeIfPresent(String.self, forKey: .backdrop)
  title = try values.decode(String.self, forKey: .title)
  averageVote = try values.decode(Float.self, forKey: .averageVote)
  overview = try values.decode(String.self, forKey: .overview)
  let releaseDateString = try values.decode(String.self, forKey: .releaseDate)
  releaseDate = DateFormatter.defaultFormatter.date(from: releaseDateString)
}
}
