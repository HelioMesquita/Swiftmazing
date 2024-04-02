//
//  RepositoryDetailInteractorTests.swift
//  SwiftmazingTests
//
//  Created by Helio Loredo Mesquita on 09/01/20.
//  Copyright © 2020 Hélio Mesquita. All rights reserved.
//

import XCTest

@testable import Swiftmazing

class RepositoryDetailInteractorTests: XCTestCase {

  var sut: RepositoryDetailInteractor!
  var presenter: PresenterSpy!
  var repository: RepositoryModel!

  class PresenterSpy: RepositoryDetailPresentationLogic {

    var presentRepositoryCalled = false

    func presentRepository(_ repository: RepositoryModel) {
      presentRepositoryCalled = true
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

    presenter = PresenterSpy()
    sut = RepositoryDetailInteractor()
    sut.presenter = presenter
  }

  override func tearDownWithError() throws {
    sut = nil
    try super.tearDownWithError()
  }

  func testWithRepository() {
    sut.repository = repository
    sut.loadScreen()
    XCTAssertTrue(presenter.presentRepositoryCalled)
  }

  func testEmptyRepository() {
    sut.loadScreen()
    XCTAssertFalse(presenter.presentRepositoryCalled)
  }

}
