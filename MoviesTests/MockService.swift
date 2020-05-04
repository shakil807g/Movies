//
//  MockService.swift
//  MoviesTests
//
//  Created by Khurram on 04/05/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation
import NetworkClient

final class MockService: MoviesService {
  
func getConfiguration(completion: @escaping (Result<Void, Error>) -> Void) {
  
}

func getPopular(completion: @escaping (Result<[MovieItem], Error>) -> Void) {
  
}

func getTopRated(completion: @escaping (Result<[MovieItem], Error>) -> Void) {
  
}

func getUpComing(completion: @escaping (Result<[MovieItem], Error>) -> Void) {
  
}

func getImageData(for movieItem: MovieItem, completion: @escaping (Result<Data, Error>) -> Void) {
  DispatchQueue.main.async {
    completion(.success(Data()))
  }
}
  
} // class MockService
