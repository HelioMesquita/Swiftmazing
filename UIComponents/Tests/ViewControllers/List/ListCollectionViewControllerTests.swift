//
//  ListCollectionViewControllerTests.swift
//  VisualTests
//
//  Created by Hélio Mesquita on 06/01/20.
//  Copyright © 2020 Hélio Mesquita. All rights reserved.
//

import SnapshotTesting
import XCTest

@testable import UIComponents

struct MockListCollectionViewModelProtocol: ListCollectionViewModelProtocol {
  var id: String = UUID().uuidString
  var title: String = "Title"
  var description: String = "Description"
  var additionalInfo: String = "27.3k"
  var supplementaryInfo: String = "stars"
  var image: URL?
}

class ListCollectionViewControllerTests: XCTestCase {

  var view: ListCollectionViewController<MockListCollectionViewModelProtocol>!

  override func setUpWithError() throws {
    try super.setUpWithError()
    view = ListCollectionViewController<MockListCollectionViewModelProtocol>()
    view.viewDidLoad()
    var snapshot = NSDiffableDataSourceSnapshot<
      ListSection, MockListCollectionViewModelProtocol
    >()
    snapshot.appendSections([.repo])
    snapshot.appendItems(
      [
        MockListCollectionViewModelProtocol(), MockListCollectionViewModelProtocol(),
        MockListCollectionViewModelProtocol(),
      ], toSection: .repo)
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
