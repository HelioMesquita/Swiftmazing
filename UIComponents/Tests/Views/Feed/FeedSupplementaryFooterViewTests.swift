//
//  FeedSupplementaryFooterViewTests.swift
//  VisualTests
//
//  Created by Helio Loredo Mesquita on 06/01/20.
//  Copyright © 2020 Hélio Mesquita. All rights reserved.
//

import SnapshotTesting
import XCTest

@testable import UIComponents

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
    assertSnapshot(of: self.view, as: .image)
  }

}
