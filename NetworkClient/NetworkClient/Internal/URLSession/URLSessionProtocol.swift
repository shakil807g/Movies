//
//  URLSessionProtocol.swift
//  NetworkClient
//
//  Created by Khurram on 29/04/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation

protocol URLSessionProtocol {
typealias DataTaskResult = (Data?, URLResponse?, Error?) -> Void
func dataTask(with request: URLRequest, completionHandler: @escaping DataTaskResult) -> URLSessionDataTaskProtocol
}

//MARK: Conform the protocol
extension URLSession: URLSessionProtocol {
func dataTask(with request: URLRequest, completionHandler: @escaping URLSessionProtocol.DataTaskResult) -> URLSessionDataTaskProtocol {
  dataTask(with: request, completionHandler: completionHandler) as URLSessionDataTask
}
}
