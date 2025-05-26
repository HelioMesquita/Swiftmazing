//
//  ListViewModelTests.swift
//  SwiftmazingTests
//
//  Created by Helio Loredo Mesquita on 09/01/20.
//  Copyright © 2020 Hélio Mesquita. All rights reserved.
//

import Combine
import XCTest

@testable import Swiftmazing

@MainActor
class ListViewModelTests: XCTestCase {

  var sut: ListViewModel!
  var cancellables = Set<AnyCancellable>()

  func testLoadScreen() {
    sut = ListViewModel(worker: RepositoriesWorkerSpy(), listTitle: "title", listFilter: .stars, listRepositories: [])

    sut.$state
      .receive(on: RunLoop.main)
      .sink { states in
        switch states {
        case .loading:
          break
        case .loaded(let model):
          XCTAssertNotNil(model)
        case .error(_):
          XCTFail()
        }
      }.store(in: &cancellables)

    sut.loadScreen()
  }

  func testReloadRepositoriesOnSuccess() {
    sut = ListViewModel(worker: RepositoriesWorkerSpy(), listTitle: "title", listFilter: .stars, listRepositories: [])

    sut.$state
      .receive(on: RunLoop.main)
      .sink { states in
        switch states {
        case .loading:
          break
        case .loaded(let model):
          XCTAssertNotNil(model)
          XCTAssertEqual(self.sut.currentPage, 1)
        case .error(_):
          XCTFail()
        }
      }.store(in: &cancellables)

    sut.currentPage += 10
    sut.reloadRepositories()
  }

  func testReloadRepositoriesOnFailure() {
    let worker = RepositoriesWorkerSpy(isSuccess: false)
    sut = ListViewModel(worker: worker, listTitle: "title", listFilter: .stars, listRepositories: [])

    sut.$state
      .receive(on: RunLoop.main)
      .sink { states in
        switch states {
        case .loading:
          break
        case .loaded(_):
          XCTFail()
        case .error(let message):
          XCTAssertEqual(message, "An error occurred while fetching repositories")
        }
      }.store(in: &cancellables)

    sut.loadScreen()
  }

  func testRepositySelected() {
    sut = ListViewModel(worker: RepositoriesWorkerSpy(), listTitle: "title", listFilter: .stars, listRepositories: [])
    let repository = RepositoryModel(
      name: "swiftmazing", stars: 100,
      owner: RepositoryOwnerModel(
        name: "Helio Mesquita", avatar: URL(string: "www.google.com.br")!),
      description:
        "A iOS application with layout based on App Store that can check the most starred and last updated Swift repository.",
      issues: 1, forks: 2, lastUpdate: Date(), url: URL(string: "www.google.com.br")!)

    sut.navigateToNextScreen
      .sink { action in
        switch action {
        case .detail(let _repository):
          XCTAssertEqual(_repository.name, repository.name)
        }
      }.store(in: &cancellables)

    sut.repositorySelected(repository)
  }

  func testPrefetchNextPage() {
    sut = ListViewModel(worker: RepositoriesWorkerSpy(), listTitle: "title", listFilter: .stars, listRepositories: [])

    sut.$state
      .receive(on: RunLoop.main)
      .sink { states in
        switch states {
        case .loading:
          break
        case .loaded(_):
          XCTFail()

        case .error(_):
          XCTFail()
        }
      }.store(in: &cancellables)

    sut.prefetchNextPage(index: 5)
    XCTAssertEqual(sut.currentPage, 1)
  }

  func testPrefetchNextPageOnSuccess() {
    sut = ListViewModel(worker: RepositoriesWorkerSpy(), listTitle: "title", listFilter: .stars, listRepositories: [])

    sut.$state
      .receive(on: RunLoop.main)
      .sink { states in
        switch states {
        case .loading:
          break
        case .loaded(let model):
          XCTAssertNotNil(model)
          XCTAssertEqual(self.sut.currentPage, 2)
        case .error(_):
          XCTFail()
        }
      }.store(in: &cancellables)

    sut.prefetchNextPage(index: 9)
  }

}
