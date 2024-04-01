//
//  ListRepositoryCellTests.swift
//  VisualTests
//
//  Created by Hélio Mesquita on 06/01/20.
//  Copyright © 2020 Hélio Mesquita. All rights reserved.
//

import Nimble
import Nimble_Snapshots
import XCTest

@testable import Visual

class ListRepositoryCellTests: XCTestCase {

  var view: ListRepositoryCell!

  override func setUpWithError() throws {
    try super.setUpWithError()
    view = ListRepositoryCell(frame: CGRect(x: 0, y: 0, width: 375, height: 118))
    view.titleLabel.text = "Name label"
    view.descriptionLabel.text = "Description Label"
    view.imageView.image = UIImage.Design.swift
    view.additionalInfoLabel.text = "27.31k"
    view.supplementaryInfoLabel.text = "stars"
  }

  override func tearDownWithError() throws {
    view = nil
    try super.tearDownWithError()
  }

  func testLayout() {
    expect(self.view) == snapshot()
  }

}
