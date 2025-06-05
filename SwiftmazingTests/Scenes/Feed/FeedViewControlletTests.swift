//
//  FeedViewControlletTests.swift
//  Swiftmazing
//
//  Created by Hélio Mesquita on 04/06/25.
//

import Combine
import XCTest

@testable import Swiftmazing

class FeedViewModelMock: FeedViewModelProtocol {

  var loadScreenCalled = false

  @Published var state: States<FeedModel> = .loading
  var statePublisher: AnyPublisher<Swiftmazing.States<Swiftmazing.FeedModel>, Never> {
    $state.eraseToAnyPublisher()
  }

  var navigateToNextScreen: PassthroughSubject<Swiftmazing.FeedNavigationAction, Never> = .init()

  func loadScreen() {
    loadScreenCalled = true
  }

}

class FeedViewControllerSpy: FeedViewController {

  var presentViewControllerCalled = false

  override func presentViewController(_ vc: UIViewController) {
    presentViewControllerCalled = true
  }
}

@MainActor
class FeedViewControlletTests: XCTestCase {

  func testViewDidLoadSuccess() {
    let viewModel = FeedViewModelMock()
    let sut = FeedViewController(viewModel: viewModel, scheduler: .immediate)
    sut.viewDidLoad()

    let a = MapNewsViewModel(
      topRepos: [], lastUpdated: [])
    let b = MapRepoViewModel(
      repositories: [], section: .topRepos)
    let c = MapRepoViewModel(
      repositories: [], section: .lastUpdated)

    let repositoryModel = FeedModel(news: a, topRepos: b, lastUpdated: c)

    viewModel.state = .loaded(repositoryModel)
    XCTAssertEqual(sut.dataSource.snapshot().numberOfSections, 3)
  }

  func testViewDidLoadError() {
    let viewModel = FeedViewModelMock()
    let sut = FeedViewController(viewModel: viewModel, scheduler: .immediate)

    let window = UIWindow()
    window.rootViewController = sut
    window.makeKeyAndVisible()
    sut.loadViewIfNeeded()

    viewModel.state = .error("unknown")
    XCTAssertTrue(sut.presentedViewController is UIAlertController)
  }

  func testRepositorySelected() {
    let viewModel = FeedViewModelMock()
    let sut = FeedViewControllerSpy(viewModel: viewModel, scheduler: .immediate)
    sut.viewDidLoad()

    let repository = RepositoryModel(
      name: "swiftmazing", stars: 100,
      owner: RepositoryOwnerModel(
        name: "Helio Mesquita", avatar: URL(string: "www.google.com.br")!),
      description:
        "A iOS application with layout based on App Store that can check the most starred and last updated Swift repository.",
      issues: 1, forks: 2, lastUpdate: Date(), url: URL(string: "www.google.com.br")!)

    viewModel.navigateToNextScreen.send(.detail(repository))
    XCTAssertTrue(sut.presentViewControllerCalled)
  }

  func testTopRepoListSelected() {
    let viewModel = FeedViewModelMock()
    let sut = FeedViewControllerSpy(viewModel: viewModel, scheduler: .immediate)
    sut.viewDidLoad()

    viewModel.navigateToNextScreen.send(.list(repositories: [], filter: .stars, title: "title"))
    XCTAssertTrue(sut.presentViewControllerCalled)
  }

}
