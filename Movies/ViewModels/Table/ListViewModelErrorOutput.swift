//
//  ListViewModelErrorOutput.swift
//  Movies
//
//  Created by Khurram on 01/05/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Combine
import Foundation

protocol ListViewModelErrorOutput {
var errorMessage: AnyPublisher<String, Never> { get }
}
