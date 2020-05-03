//
//  HandleError.swift
//  Movies
//
//  Created by Khurram on 30/04/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import NetworkClient
import Foundation

func handleError(_ error: Error) -> String? {
  print(error)
  if let networkClientError = error as? NetworkClientError {
    switch networkClientError {
    case .noData:
      return "Network error, please try later"
    case .urlCreationFailed:
      return "Network configuration error"
    }
  }
  return nil
}
