//
//  ListPresenterTests.swift
//  SwiftmazingTests
//
//  Created by Helio Loredo Mesquita on 09/01/20.
//  Copyright © 2020 Hélio Mesquita. All rights reserved.
//

import XCTest

@testable import Swiftmazing

class ListPresenterTests: XCTestCase {
  var sut: ListPresenter!
  var viewController: ViewControllerSpy!

  class ViewControllerSpy: ListDisplayLogic {

    var showDetailCalled: Bool = false
    var showTitleCalled: Bool = false
    var showReloadCalled: Bool = false
    var showNextPageCalled: Bool = false
    var showTryAgainCalled: Bool = false

    func showTitle(_ title: String) {
      showTitleCalled = true
    }

    func showReload(with viewModels: [List.ListCellViewModel]) {
      showReloadCalled = true
    }
    func showNextPage(with viewModels: [List.ListCellViewModel]) {
      showNextPageCalled = true
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
    sut = ListPresenter()
    sut.viewController = viewController
  }

  override func tearDownWithError() throws {
    sut = nil
    try super.tearDownWithError()
  }
  
  func testPresentTitle() {
    sut.presentTitle("")
    XCTAssertTrue(viewController.showTitleCalled)
  }
  
  func testReloadMap() {
    sut.reloadMap(RepositoriesModel(items: []).items)
    XCTAssertTrue(viewController.showReloadCalled)

  }
  
  func testNextPageMap() {
    sut.nextPageMap(RepositoriesModel(items: []).items)
    XCTAssertTrue(viewController.showNextPageCalled)
  }
  
  func testPresentDetail() {
    sut.presentDetail()
    XCTAssertTrue(viewController.showDetailCalled)
  }
  
  func testPresentTryAgain() {
    sut.presentTryAgain(message: "")
    XCTAssertTrue(viewController.showTryAgainCalled)
  }
    
}
