//
//  FeedViewModelTests.swift
//  SwiftmazingTests
//
//  Created by Helio Loredo Mesquita on 09/01/20.
//  Copyright © 2020 Hélio Mesquita. All rights reserved.
//

import Combine
import XCTest

@testable import Swiftmazing

@MainActor
class FeedViewModelTests: XCTestCase {

  var sut: FeedViewModel!
  var cancellables = Set<AnyCancellable>()

  func testLoadScreenOnSuccess() {
    sut = FeedViewModel(worker: RepositoriesWorkerSpy())

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

  func testLoadScreenOnFailure() {
    let worker = RepositoriesWorkerSpy(isSuccess: false)
    sut = FeedViewModel(worker: worker)

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

  func testRepositorySelected() {
    let worker = RepositoriesWorkerSpy()
    sut = FeedViewModel(worker: worker)
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
        case .list(_, _, _):
          XCTFail()

        case .detail(let _repository):
          XCTAssertEqual(_repository.name, repository.name)

        }
      }.store(in: &cancellables)

    sut.repositorySelected(repository)
  }

  func testTopRepoListSelected() {
    let worker = RepositoriesWorkerSpy()
    sut = FeedViewModel(worker: worker)
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
        case .list(let _repositories, let filter, let title):
          XCTAssertTrue(_repositories.first?.name == repository.name)
          XCTAssertTrue(filter == .stars)
          XCTAssertEqual(title, "title")

        case .detail(let _repository):
          XCTAssertEqual(_repository.name, repository.name)

        }
      }.store(in: &cancellables)


    sut.topRepoListSelected([repository], title: "title")
  }

  func testLastUpdatedListSelected() {
    let worker = RepositoriesWorkerSpy()
    sut = FeedViewModel(worker: worker)
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
        case .list(let _repositories, let filter, let title):
          XCTAssertTrue(_repositories.first?.name == repository.name)
          XCTAssertTrue(filter == .updated)
          XCTAssertEqual(title, "title")

        case .detail(let _repository):
          XCTAssertEqual(_repository.name, repository.name)

        }
      }.store(in: &cancellables)


    sut.lastUpdatedListSelected([repository], title: "title")
  }

}
