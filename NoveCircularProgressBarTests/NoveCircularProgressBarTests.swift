//
//  NoveCircularProgressBarTests.swift
//  NoveCircularProgressBarTests
//
//  Created by Steve Gigou on 19/02/2020.
//  Copyright © 2020 Novesoft. All rights reserved.
//

import XCTest
@testable import NoveCircularProgressBar

class NoveCircularProgressBarTests: XCTestCase {
  
  private let progressBar = NoveCircularProgressBar(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
  
  func testUpdateProgress() {
    XCTAssertEqual(progressBar.progress, 0.0)
    progressBar.updateProgress(to: 0.75, animated: false)
    XCTAssertEqual(progressBar.progress, 0.75)
    progressBar.updateProgress(to: 0.25, animated: false)
    XCTAssertEqual(progressBar.progress, 0.25)
  }
  
}
