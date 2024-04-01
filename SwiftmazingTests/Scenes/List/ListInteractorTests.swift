//
//  FeedInteractorTests.swift
//  SwiftmazingTests
//
//  Created by Helio Loredo Mesquita on 09/01/20.
//  Copyright © 2020 Hélio Mesquita. All rights reserved.
//

import XCTest

@testable import Swiftmazing

class ListInteractorTests: XCTestCase {
  
  var sut: ListInteractor!
  var presenter: PresenterSpy!
  var worker: RepositoriesWorkerSpy!
  var repositories: [RepositoryModel]!
  var repository: RepositoryModel!

  class PresenterSpy: ListPresentationLogic {

    var presentTitleCalled: Bool = false
    var reloadMapCalled: Bool = false
    var nextPageMapCalled: Bool = false
    var presentDetailCalled: Bool = false
    var presentTryAgainCalled: Bool = false

    func presentTitle(_ title: String) {
      presentTitleCalled = true
    }

    func reloadMap(_ repositories: [RepositoryModel]) {
      reloadMapCalled = true
    }

    func nextPageMap(_ repositories: [RepositoryModel]) {
      nextPageMapCalled = true
    }

    func presentDetail() {
      presentDetailCalled = true
    }

    func presentTryAgain(message: String) {
      presentTryAgainCalled = true
    }

  }
  
  override func setUpWithError() throws {
    try super.setUpWithError()
    repositories = RepositoriesModel(items: []).items
    repository = RepositoriesModel(items: []).items.first

    worker = RepositoriesWorkerSpy()
    presenter = PresenterSpy()
    sut = ListInteractor(worker: worker)
    sut.presenter = presenter
  }
  
  override func tearDownWithError() throws {
    sut = nil
    try super.tearDownWithError()
  }
  
  func testLoadScreen() {
    sut.loadScreen()
    XCTAssertTrue(presenter.presentTitleCalled)
    XCTAssertTrue(presenter.reloadMapCalled)
  }
  
  func testReloadRepositoriesOnSuccess() {
    sut.reloadRepositories()
    sut.handleReloadSuccess(RepositoriesModel(items: []))
    XCTAssertEqual(sut.currentPage, 1)
    XCTAssertTrue(presenter.reloadMapCalled)
  }
  
  func testReloadRepositoriesOnFailure() {
    worker.isSuccess = false
    sut.reloadRepositories()
    sut.handleError(NSError(domain: "", code: 0))
    XCTAssertEqual(sut.currentPage, 1)
    XCTAssertTrue(presenter.presentTryAgainCalled)
  }
  
  func testRepositySelected() {
    sut.repositorySelected(repository)
    XCTAssertTrue(sut.selectedRepository === repository)
    XCTAssertTrue(presenter.presentDetailCalled)
  }
  
  func testPrefetchNextPage() {
    sut.prefetchNextPage(index: 5)
    XCTAssertEqual(sut.currentPage, 1)
  }
  
  func testPrefetchNextPageOnSuccess() {
    sut.prefetchNextPage(index: 9)
    XCTAssertEqual(sut.currentPage, 2)
  }
  
}
