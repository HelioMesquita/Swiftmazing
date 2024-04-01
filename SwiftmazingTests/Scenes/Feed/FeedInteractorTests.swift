//
//  FeedInteractorTests.swift
//  SwiftmazingTests
//
//  Created by Helio Loredo Mesquita on 09/01/20.
//  Copyright © 2020 Hélio Mesquita. All rights reserved.
//

import XCTest

@testable import Swiftmazing

class FeedInteractorTests: XCTestCase {

  class PresenterSpy: FeedPresentationLogic {

    var mapResponseCalled = false
    var presentListCalled = false
    var presentDetailCalled = false
    var presentTryAgainCalled = false

    func mapResponse(_ topRepoResponse: RepositoriesModel, _ mostRecentResponse: RepositoriesModel)
    {
      mapResponseCalled = true
    }

    func presentList() {
      presentListCalled = true
    }

    func presentDetail() {
      presentDetailCalled = true
    }

    func presentTryAgain(message: String) {
      presentTryAgainCalled = true
    }

  }

  var sut: FeedInteractor!
  var presenter: PresenterSpy!
  var worker: RepositoriesWorkerSpy!
  var repositories: [RepositoryModel]!
  var repository: RepositoryModel!

  override func setUpWithError() throws {
    try super.setUpWithError()
    repository = RepositoryModel(
      name: "swiftmazing", stars: 100,
      owner: RepositoryOwnerModel(
        name: "Helio Mesquita", avatar: URL(string: "www.google.com.br")!),
      description:
        "A iOS application with layout based on App Store that can check the most starred and last updated Swift repository.",
      issues: 1, forks: 2, lastUpdate: Date(), url: URL(string: "www.google.com.br")!)

    worker = RepositoriesWorkerSpy()
    presenter = PresenterSpy()
    sut = FeedInteractor(worker: worker)
    sut.presenter = presenter
  }

  override func tearDownWithError() throws {
    sut = nil
    try super.tearDownWithError()
  }

  func testLoadScreenOnSuccess() {
    sut.handleSuccess(RepositoriesModel(items: []), RepositoriesModel(items: []))
    XCTAssertTrue(presenter.mapResponseCalled)
  }

  func testLoadScreenOnFailure() {
    sut.handleError(NSError(domain: "", code: 0))
    XCTAssertFalse(presenter.mapResponseCalled)
  }

  func testRepositorySelected() {
    sut.repositorySelected(repository)
    XCTAssertTrue(sut.selectedRepository === repository)
    XCTAssertTrue(presenter.presentDetailCalled)
  }

  func testTopRepoListSelected() {
    sut.topRepoListSelected([repository], title: "title")
    XCTAssertTrue(sut.listRepositories.first === repository)
    XCTAssertTrue(sut.listFilter == .stars)
    XCTAssertTrue(sut.listTitle == "title")
  }

  func testLastUpdatedListSelected() {
    sut.lastUpdatedListSelected([repository], title: "title")
    XCTAssertTrue(sut.listRepositories.first === repository)
    XCTAssertTrue(sut.listFilter == .updated)
    XCTAssertTrue(sut.listTitle == "title")
  }

}
