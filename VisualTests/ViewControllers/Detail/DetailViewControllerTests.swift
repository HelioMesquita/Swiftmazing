//
//  FeedCollectionViewControllerTests.swift
//  VisualTests
//
//  Created by Hélio Mesquita on 06/01/20.
//  Copyright © 2020 Hélio Mesquita. All rights reserved.
//

import Nimble
import Nimble_Snapshots
import XCTest

@testable import Visual

class DetailViewControllerTests: XCTestCase {

  var view: DetailViewController!

  override func setUpWithError() throws {
    try super.setUpWithError()
    view = DetailViewController()
    view.titleLabel.text = "Title"
    view.authorLabel.text = "Author"
    view.setDescriptions(["Descriptions", "Descriptions"])
  }

  override func tearDownWithError() throws {
    view = nil
    try super.tearDownWithError()
  }

  func testLayout() {
    expect(self.view).to(haveValidDynamicSizeSnapshot(sizes: sizes))
  }

}
