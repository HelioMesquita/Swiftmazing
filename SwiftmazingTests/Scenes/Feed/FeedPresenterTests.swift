//
//  FeedPresenterTests.swift
//  SwiftmazingTests
//
//  Created by Helio Loredo Mesquita on 09/01/20.
//  Copyright © 2020 Hélio Mesquita. All rights reserved.
//

import XCTest

@testable import Swiftmazing

class FeedPresenterTests: XCTestCase {

  var sut: FeedPresenter!
  var viewController: ViewControllerSpy!

  class ViewControllerSpy: FeedDisplayLogic {
    var showCalled: Bool = false
    var showListCalled: Bool = false
    var showDetailCalled: Bool = false
    var showTryAgainCalled: Bool = false

    func show(_ viewModel: Feed.ViewModel) {
      showCalled = true
    }

    func showList() {
      showListCalled = true
    }

    func showDetail() {
      showDetailCalled = true
    }

    func showTryAgain(title: String, message: String) {
      showTryAgainCalled = true
    }

    func reload() {}

  }

  override func setUpWithError() throws {
    try super.setUpWithError()
    viewController = ViewControllerSpy()
    sut = FeedPresenter()
    sut.viewController = viewController
  }

  override func tearDownWithError() throws {
    sut = nil
    try super.tearDownWithError()
  }

  func testMapResponse() {
    sut.mapResponse(RepositoriesModel(items: []), RepositoriesModel(items: []))
    XCTAssertTrue(viewController.showCalled)
  }

  func testPresentTryAgain() {
    sut.presentTryAgain(message: "")
    XCTAssertTrue(viewController.showTryAgainCalled)
  }

  func testPresentList() {
    sut.presentList()
    XCTAssertTrue(viewController.showListCalled)
  }

  func testPresentDetail() {
    sut.presentDetail()
    XCTAssertTrue(viewController.showDetailCalled)
  }

}
