//
//  ListViewControllerTests.swift
//  Swiftmazing
//
//  Created by Hélio Mesquita on 04/06/25.
//

import Combine
import XCTest

@testable import Swiftmazing

class ListViewModelMock: ListViewModelProtocol {

  @Published var state:
    Swiftmazing.States<(repositories: [Swiftmazing.ListCellViewModel], title: String)> = .loading
  var statePublisher:
    AnyPublisher<
      Swiftmazing.States<(repositories: [Swiftmazing.ListCellViewModel], title: String)>, Never
    >
  {
    $state.eraseToAnyPublisher()
  }

  var navigateToNextScreen: PassthroughSubject<Swiftmazing.ListNavigationAction, Never> = .init()
  var reloadRepositoriesCalled = false
  var repositorySelectedCalled = false
  var prefetchNextPageCalled = false
  var loadScreenCalled = false

  func reloadRepositories() {
    reloadRepositoriesCalled = true
  }

  func repositorySelected(_ repository: Swiftmazing.RepositoryModel) {
    repositorySelectedCalled = true

  }

  func prefetchNextPage(index: Int) {
    prefetchNextPageCalled = true
  }

  func loadScreen() {
    loadScreenCalled = true
  }

}

class ListViewControllerSpy: ListViewController {

  var presentViewControllerCalled = false

  override func presentViewController(_ vc: UIViewController) {
    presentViewControllerCalled = true
  }

}

@MainActor
class ListViewControllerTests: XCTestCase {

  func testSuccessLoadScreen() {
    let sut = ListViewControllerSpy(
      listTitle: "", listFilter: .stars, listRepositories: [], worker: RepositoriesWorkerSpy(),
      sheduler: .immediate)
    sut.viewDidLoad()
    XCTAssertEqual(sut.dataSource.snapshot().numberOfSections, 1)
  }

  func testOpenDetail() {
    let repository = RepositoryModel(
      name: "swiftmazing", stars: 100,
      owner: RepositoryOwnerModel(
        name: "Helio Mesquita", avatar: URL(string: "www.google.com.br")!),
      description:
        "A iOS application with layout based on App Store that can check the most starred and last updated Swift repository.",
      issues: 1, forks: 2, lastUpdate: Date(), url: URL(string: "www.google.com.br")!)
    let sut = ListViewControllerSpy(
      listTitle: "",
      listFilter: .stars,
      listRepositories: [],
      worker: RepositoriesWorkerSpy(isSuccess: false),
      sheduler: .immediate)
    sut.viewDidLoad()
    sut.viewModel.navigateToNextScreen.send(.detail(repository))
    XCTAssertTrue(sut.presentViewControllerCalled)
  }

}
