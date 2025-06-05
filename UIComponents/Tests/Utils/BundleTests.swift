//
//  BundleTests.swift
//  InfrastructureTests
//
//  Created by Helio Loredo Mesquita on 06/01/20.
//  Copyright © 2020 Hélio Mesquita. All rights reserved.
//

import XCTest

@testable import UIComponents

class BundleTests: XCTestCase {

  func testReturnsModuleName() {
    XCTAssertEqual(
      Bundle.module.bundleIdentifier?.lowercased(),
      "UIComponents.UIComponents.resources".lowercased())
  }

}
