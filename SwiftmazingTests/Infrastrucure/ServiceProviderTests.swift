//
//  ServiceProviderTests.swift
//  Swiftmazing
//
//  Created by Hélio Mesquita on 26/05/25.
//

import Combine
import Foundation
import XCTest

@testable import Swiftmazing

@MainActor
class ServiceProviderTests: XCTestCase {

  func testDecoder() {
    let serviceProvider = ServiceProvider()
    let decoder = serviceProvider.jsonDecoder
    switch decoder.dateDecodingStrategy  {
    case .iso8601:
      XCTAssertTrue(true)
    default:
      XCTFail()
    }
  }

}
