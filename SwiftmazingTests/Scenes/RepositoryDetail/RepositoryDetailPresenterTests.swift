//
//  RepositoryDetailPresenterTests.swift
//  SwiftmazingTests
//
//  Created by Helio Loredo Mesquita on 09/01/20.
//  Copyright © 2020 Hélio Mesquita. All rights reserved.
//

import XCTest

@testable import Swiftmazing

class RepositoryDetailPresenterTests: XCTestCase {
  
  var sut: RepositoryDetailPresenter!
  var viewController: ViewControllerSpy!
  var repository: RepositoryModel!

  class ViewControllerSpy: RepositoryDetailDisplayLogic {

    var showImageCalled: Bool = false
    var showTitleCalled: Bool = false
    var showAuthorCalled: Bool = false
    var showDescriptionsCalled: Bool = false
    var showButtonTitleCalled: Bool = false

    func showImage(_ imageURL: URL) {
      showImageCalled = true
    }

    func showTitle(_ text: String) {
      showTitleCalled = true
    }

    func showAuthor(_ text: String) {
      showAuthorCalled = true
    }

    func showDescriptions(_ texts: [String]) {
      showDescriptionsCalled = true
    }

    func showButtonTitle(_ text: String) {
      showButtonTitleCalled = true
    }

  }
  
  override func setUpWithError() throws {
    try super.setUpWithError()
    repository = RepositoryModel(
      name: "swiftmazing", stars: 100,
      owner: RepositoryOwnerModel(
        name: "Helio Mesquita", avatar: URL(string: "www.google.com.br")!),
      description:
        "A iOS application with layout based on App Store that can check the most starred and last updated Swift repository.",
      issues: 1, forks: 2, lastUpdate: Date(), url: URL(string: "www.google.com.br")!)
    
    viewController = ViewControllerSpy()
    sut = RepositoryDetailPresenter()
    sut.viewController = viewController
  }

  override func tearDownWithError() throws {
    sut = nil
    try super.tearDownWithError()
  }
  
  func testPresentRepository() {
    sut.presentRepository(repository)
    XCTAssertTrue(viewController.showImageCalled)
    XCTAssertTrue(viewController.showTitleCalled)
    XCTAssertTrue(viewController.showAuthorCalled)
    XCTAssertTrue(viewController.showDescriptionsCalled)
    XCTAssertTrue(viewController.showButtonTitleCalled)
  }
  
}
