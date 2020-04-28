//
//  MoviesUITests.swift
//  MoviesUITests
//
//  Created by Khurram on 28/04/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import XCTest

final class MoviesUITests: XCTestCase {

override func setUpWithError() throws {
    // Put setup code here. This method is called before the invocation of each test method in the class.

    // In UI tests it is usually best to stop immediately when a failure occurs.
    continueAfterFailure = false

    // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
}


func testExample() throws {
  // UI tests must launch the application that they test.
    
  let app = XCUIApplication()
  app.launch()

  // Use recording to get started writing UI tests.
  // Use XCTAssert and related functions to verify your tests produce the correct results.
}

func testLaunchPerformance() throws {
  if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
        // This measures how long it takes to launch your application.
    measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
      XCUIApplication().launch()
    }
  }
}
}
