//
//  RequestProviderProtocolTests.swift
//  InfrastructureTests
//
//  Created by Helio Loredo Mesquita on 06/01/20.
//  Copyright © 2020 Hélio Mesquita. All rights reserved.
//

import XCTest

@testable import Infrastructure

class RequestProviderProtocolTests: XCTestCase {

  var sut: RequestProviderProtocol!

  override func setUpWithError() throws {
    try super.setUpWithError()
    sut = MockProvider()
  }

  override func tearDownWithError() throws {
    sut = nil
    try super.tearDownWithError()
  }

  func testURLRequestMethodItReturnsACorrectURLWithQueryParameters() {
    let urlString = sut.asURLRequest.url?.absoluteString
    XCTAssertEqual(urlString, "https://api.github.com/repositories?key=value")
  }

  func testURLRequestMethodItReturnsAllHeaders() {
    let headers = sut.asURLRequest.allHTTPHeaderFields
    XCTAssertEqual(headers, ["Content-Type": "application/json"])
  }

  func testURLRequestMethodItReturnsHttbBodyData() {
    let httpBody = sut.asURLRequest.httpBody
    XCTAssertNotNil(httpBody)
  }

}
