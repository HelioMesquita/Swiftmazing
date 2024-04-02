//
//  FeedNewsCellTests.swift
//  VisualTests
//
//  Created by Helio Loredo Mesquita on 06/01/20.
//  Copyright © 2020 Hélio Mesquita. All rights reserved.
//

import SnapshotTesting
import XCTest

@testable import UIComponents

class FeedNewsCellTests: XCTestCase {

  func createImage() -> UIImageView {
    let imageView = UIImageView(image: UIImage.Design.swift)
    imageView.contentMode = .scaleAspectFill
    imageView.clipsToBounds = true
    return imageView
  }

  var view: FeedNewsCell!

  override func setUpWithError() throws {
    try super.setUpWithError()
    view = FeedNewsCell(frame: CGRect(x: 0, y: 0, width: 375, height: 320))
    view.titleLabel.text = "Title label"
    view.subtitleLabel.text = "Subtitle label"
    view.descriptionLabel.text = "Description Label"
    view.oddImagesStackView.addArrangedSubview(createImage())
    view.oddImagesStackView.addArrangedSubview(createImage())
    view.oddImagesStackView.addArrangedSubview(createImage())
    view.oddImagesStackView.addArrangedSubview(createImage())
    view.oddImagesStackView.addArrangedSubview(createImage())
    view.evenImagesStackView.addArrangedSubview(createImage())
    view.evenImagesStackView.addArrangedSubview(createImage())
    view.evenImagesStackView.addArrangedSubview(createImage())
    view.evenImagesStackView.addArrangedSubview(createImage())
    view.evenImagesStackView.addArrangedSubview(createImage())
  }

  override func tearDownWithError() throws {
    view = nil
    try super.tearDownWithError()
  }

  func testLayout() {
    assertSnapshot(of: self.view, as: .image)
  }

}
