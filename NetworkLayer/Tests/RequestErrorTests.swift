//
//  RequestErrorTests.swift
//  InfrastructureTests
//
//  Created by Helio Loredo Mesquita on 06/01/20.
//  Copyright © 2020 Hélio Mesquita. All rights reserved.
//

import XCTest

@testable import NetworkLayer

class RequestErrorTests: XCTestCase {

  func testLocalizedDescriptionReturnsTextFromLocalizableStrings() {
    XCTAssertEqual(
      RequestError.badRequest.localizedDescription, "There was an error loading your data")
  }

}
