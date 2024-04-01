//
//  FeedSupplementaryFooterViewTests.swift
//  VisualTests
//
//  Created by Helio Loredo Mesquita on 06/01/20.
//  Copyright © 2020 Hélio Mesquita. All rights reserved.
//

import Nimble
import Nimble_Snapshots
import XCTest

@testable import Visual

class FeedSupplementaryFooterViewTests: XCTestCase {

  var view: FeedSupplementaryFooterView!

  override func setUpWithError() throws {
    try super.setUpWithError()
    view = FeedSupplementaryFooterView(frame: CGRect(x: 0, y: 0, width: 375, height: 40))

  }

  override func tearDownWithError() throws {
    view = nil
    try super.tearDownWithError()
  }

  func testLayout() {
    expect(view) == snapshot()
  }

}
