//
//  FeedRepositoryCellTests.swift
//  VisualTests
//
//  Created by Helio Loredo Mesquita on 06/01/20.
//  Copyright © 2020 Hélio Mesquita. All rights reserved.
//

import SnapshotTesting
import XCTest

@testable import Visual

class FeedRepositoryCellTests: XCTestCase {

  var view: FeedRepositoryCell!

  override func setUpWithError() throws {
    try super.setUpWithError()
    view = FeedRepositoryCell(frame: CGRect(x: 0, y: 0, width: 375, height: 79))
    view.titleLabel.text = "Name label"
    view.descriptionLabel.text = "Description Label"
    view.imageView.image = UIImage.Design.swift
    view.additionalInfoLabel.text = "27.1k"
    view.supplementaryInfoLabel.text = "stars"
  }

  override func tearDownWithError() throws {
    view = nil
    try super.tearDownWithError()
  }

  func testLayout() {
    assertSnapshot(of: self.view, as: .image)
  }

}
