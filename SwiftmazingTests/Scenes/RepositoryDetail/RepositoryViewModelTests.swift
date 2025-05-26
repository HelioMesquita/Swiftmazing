//
//  RepositoryViewModelTests.swift
//  SwiftmazingTests
//
//  Created by Helio Loredo Mesquita on 09/01/20.
//  Copyright © 2020 Hélio Mesquita. All rights reserved.
//

import Combine
import XCTest

@testable import Swiftmazing

class RepositoryViewModelTests: XCTestCase {

  var sut: RepositoryDetailViewModel!
  var cancellables = Set<AnyCancellable>()

  func testLoadScreen() {
    let repository = RepositoryModel(
      name: "swiftmazing", stars: 100,
      owner: RepositoryOwnerModel(
        name: "Helio Mesquita", avatar: URL(string: "www.google.com.br")!),
      description:
        "A iOS application with layout based on App Store that can check the most starred and last updated Swift repository.",
      issues: 1, forks: 2, lastUpdate: Date(), url: URL(string: "www.google.com.br")!)
    sut = RepositoryDetailViewModel(repository: repository)

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

  func testOpenRepository() {
    let repository = RepositoryModel(
      name: "swiftmazing", stars: 100,
      owner: RepositoryOwnerModel(
        name: "Helio Mesquita", avatar: URL(string: "www.google.com.br")!),
      description:
        "A iOS application with layout based on App Store that can check the most starred and last updated Swift repository.",
      issues: 1, forks: 2, lastUpdate: Date(), url: URL(string: "www.google.com.br")!)
    sut = RepositoryDetailViewModel(repository: repository)

    sut.navigateToNextScreen
      .sink { action in
        switch action {
        case .openRepository(let url):
          XCTAssertEqual(repository.url, url)
        }
      }.store(in: &cancellables)

    sut.openRepository()
  }

}
