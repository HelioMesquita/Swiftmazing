//
//  FeedSupplementaryFooterViewTests.swift
//  VisualTests
//
//  Created by Helio Loredo Mesquita on 06/01/20.
//  Copyright © 2020 Hélio Mesquita. All rights reserved.
//

import SnapshotTesting
import XCTest

@testable import Visual

class FeedSupplementaryHeaderViewTests: XCTestCase {

  var view: FeedSupplementaryHeaderView!

  override func setUpWithError() throws {
    try super.setUpWithError()
    view = FeedSupplementaryHeaderView(frame: CGRect(x: 0, y: 0, width: 375, height: 40))
    view.label.text = "Name label"
    view.button.setTitle("See more", for: .normal)
  }

  override func tearDownWithError() throws {
    view = nil
    try super.tearDownWithError()
  }

  func testLayout() {
    assertSnapshot(of: self.view, as: .image)
  }

}
