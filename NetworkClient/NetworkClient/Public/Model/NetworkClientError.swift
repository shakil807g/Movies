//
//  NetworkClientError.swift
//  NetworkClient
//
//  Created by Khurram on 29/04/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation

public enum NetworkClientError {
case urlCreationFailed
case noData
}
extension NetworkClientError: Error {}
