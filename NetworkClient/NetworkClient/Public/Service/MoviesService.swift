//
//  MoviesService.swift
//  NetworkClient
//
//  Created by Khurram on 28/04/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation

public protocol MoviesService {
func getConfiguration(completion: @escaping(Result<Void, Error>) -> Void)
func getPopular(completion: @escaping(Result<[MovieItem], Error>) -> Void)
func getTopRated(completion: @escaping(Result<[MovieItem], Error>) -> Void)
func getUpComing(completion: @escaping(Result<[MovieItem], Error>) -> Void)
}
