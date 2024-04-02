//
//  Int+UtilsTests.swift
//  SwiftmazingTests
//
//  Created by Hélio Mesquita on 09/01/20.
//  Copyright © 2020 Hélio Mesquita. All rights reserved.
//

import XCTest

@testable import Swiftmazing

class IntUtilsTests: XCTestCase {

  func testKiloFormat() {
    let value: Int = 100
    XCTAssertEqual(value.kiloFormat, "100")
  }

  func testLessThanKiloFormat() {
    let value: Int = 1000
    XCTAssertEqual(value.kiloFormat, "1k")
  }

  func test10TimesKiloFormat() {
    let value: Int = 10000
    XCTAssertEqual(value.kiloFormat, "10k")
  }

  func testMultipleTimesKiloFormat() {
    let value: Int = 20201
    XCTAssertEqual(value.kiloFormat, "20.2k")
  }
}
