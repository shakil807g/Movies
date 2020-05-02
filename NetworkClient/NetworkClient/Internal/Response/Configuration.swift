//
//  Configuration.swift
//  NetworkClient
//
//  Created by Khurram on 02/05/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation

struct Configuration: Decodable {
let images: ImagesConfiguration
}

extension Configuration {
func getImageURL(movie: MovieItem) -> URL? {
  if let backdrop = movie.backdrop,
    let size = images.backdropSizes.last {
    return URL(string: images.secureBaseUrl + "/" + size + "/" + backdrop)
  } else if let poster = movie.poster,
    let size = images.posterSizes.last {
    return URL(string: images.secureBaseUrl + "/" + size + "/" + poster)
  }
  return nil
}
}
