//
//  FeedCollectionViewControllerTests.swift
//  VisualTests
//
//  Created by Hélio Mesquita on 06/01/20.
//  Copyright © 2020 Hélio Mesquita. All rights reserved.
//

import SnapshotTesting
import XCTest

@testable import Visual

class MockFeedCollectionViewModelProtocol: FeedCollectionViewModelProtocol {
  var title: String = "Title"
  var description: String = "Description"
  var subtitle: String? = "Subtitle"
  var additionalInfo: String? = "Additional Info"
  var supplementaryInfo: String? = "Supplementary Info"
  var images: [URL] = []
}

class FeedCollectionViewControllerTests: XCTestCase {

  var view: FeedCollectionViewController<MockFeedCollectionViewModelProtocol>!

  override func setUpWithError() throws {
    try super.setUpWithError()
    view = FeedCollectionViewController<MockFeedCollectionViewModelProtocol>()
    var snapshot = NSDiffableDataSourceSnapshot<
      FeedSection, MockFeedCollectionViewModelProtocol
    >()
    snapshot.appendSections([.news, .topRepos, .lastUpdated])
    snapshot.appendItems(
      [MockFeedCollectionViewModelProtocol(), MockFeedCollectionViewModelProtocol()],
      toSection: .news)
    snapshot.appendItems(
      [
        MockFeedCollectionViewModelProtocol(), MockFeedCollectionViewModelProtocol(),
        MockFeedCollectionViewModelProtocol(),
      ], toSection: .topRepos)
    snapshot.appendItems(
      [
        MockFeedCollectionViewModelProtocol(), MockFeedCollectionViewModelProtocol(),
        MockFeedCollectionViewModelProtocol(),
      ], toSection: .lastUpdated)
    view.dataSource.apply(snapshot, animatingDifferences: false)
  }

  override func tearDownWithError() throws {
    view = nil
    try super.tearDownWithError()
  }

  func testLayout() {
    assertSnapshot(of: self.view, as: .image)
  }

}
