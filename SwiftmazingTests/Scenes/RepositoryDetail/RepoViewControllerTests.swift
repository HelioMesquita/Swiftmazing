//
//  RepoViewControllerTests.swift
//  Swiftmazing
//
//  Created by Hélio Mesquita on 04/06/25.
//

import Combine
import XCTest

@testable import Swiftmazing

class RepoViewModelMock: RepoDetailViewModelProtocol {

  @Published var state: States<RepoDetailModel> = .loading
  var statePublisher: AnyPublisher<States<RepoDetailModel>, Never> {
    $state.eraseToAnyPublisher()
  }

  var navigateToNextScreen:
    PassthroughSubject<Swiftmazing.RepositoryDetailNavigationAction, Never> = .init()

  var openRepositoryCalled = false
  var loadScreenCalled = false

  func openRepository() {
    openRepositoryCalled = true
  }

  func loadScreen() {
    loadScreenCalled = true
  }

}

class RepoViewControllerSpy: RepoDetailViewController {

  var openRepositoryCalled = false
  var setModelCalled = false

  override func openSafari(_ url: URL) {
    openRepositoryCalled = true
  }

  override func setModel(_ model: RepoDetailModel) {
    setModelCalled = true
  }

}

@MainActor
class RepoViewControllerTests: XCTestCase {

  func testLoadScreen() {
    let repository = RepositoryModel(
      name: "swiftmazing", stars: 100,
      owner: RepositoryOwnerModel(
        name: "Helio Mesquita", avatar: URL(string: "www.google.com.br")!),
      description:
        "A iOS application with layout based on App Store that can check the most starred and last updated Swift repository.",
      issues: 1, forks: 2, lastUpdate: Date(), url: URL(string: "www.google.com.br")!)
    let sut = RepoViewControllerSpy(repository: repository, scheduler: .immediate)
    sut.viewDidLoad()
    let model = RepoDetailModel(
      image: repository.owner.avatar,
      title: repository.name,
      author: repository.owner.name,
      descriptions: [],
      buttonTitle: Text.seeRepository.value)
    sut.viewModel.state = .loaded(model)
    XCTAssertTrue(sut.setModelCalled)
  }

  func testOpenSafari() {
    let repository = RepositoryModel(
      name: "swiftmazing", stars: 100,
      owner: RepositoryOwnerModel(
        name: "Helio Mesquita", avatar: URL(string: "www.google.com.br")!),
      description:
        "A iOS application with layout based on App Store that can check the most starred and last updated Swift repository.",
      issues: 1, forks: 2, lastUpdate: Date(), url: URL(string: "www.google.com.br")!)
    let sut = RepoViewControllerSpy(repository: repository, scheduler: .immediate)
    sut.viewDidLoad()
    sut.viewModel.navigateToNextScreen.send(.openRepository(url: repository.url))
    XCTAssertTrue(sut.openRepositoryCalled)
  }

}
