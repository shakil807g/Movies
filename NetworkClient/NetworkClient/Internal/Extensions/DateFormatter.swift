//
//  DateFormatter.swift
//  NetworkClient
//
//  Created by Khurram on 28/04/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation

extension DateFormatter {
static let defaultFormatter: DateFormatter = {
  let dateFormatter = DateFormatter()
  dateFormatter.dateFormat = "yyyy-MM-dd"
  return dateFormatter
}()
}
