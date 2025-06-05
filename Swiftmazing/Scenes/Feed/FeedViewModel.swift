//
//  FeedViewModel.swift
//  Swiftmazing
//
//  Created by Hélio Mesquita on 13/05/25.
//

import Combine

enum FeedNavigationAction {
  case list(repositories: [RepositoryModel], filter: RepositoriesRequest.Filter, title: String)
  case detail(RepositoryModel)
}

@MainActor
protocol FeedViewModelProtocol: BaseViewModelProtocol where T == States<FeedModel> {
  var navigateToNextScreen: PassthroughSubject<FeedNavigationAction, Never> { get set }
  func repositorySelected(_ repository: RepositoryModel)
  func topRepoListSelected(_ repositories: [RepositoryModel], title: String)
  func lastUpdatedListSelected(_ repositories: [RepositoryModel], title: String)
}

extension FeedViewModelProtocol {

  func repositorySelected(_ repository: RepositoryModel) {
    navigateToNextScreen.send(.detail(repository))
  }

  func topRepoListSelected(_ repositories: [RepositoryModel], title: String) {
    navigateToNextScreen.send(.list(repositories: repositories, filter: .stars, title: title))
  }

  func lastUpdatedListSelected(_ repositories: [RepositoryModel], title: String) {
    navigateToNextScreen.send(.list(repositories: repositories, filter: .updated, title: title))
  }

}

@MainActor
class FeedViewModel: FeedViewModelProtocol {

  @Published var state: States<FeedModel> = .loading
  var statePublisher: AnyPublisher<States<FeedModel>, Never> {
    $state.eraseToAnyPublisher()
  }

  var navigateToNextScreen: PassthroughSubject<FeedNavigationAction, Never> = .init()
  let worker: RepositoriesWorkerProtocol

  init(worker: RepositoriesWorkerProtocol = RepositoriesService()) {
    self.worker = worker
  }

  func loadScreen() {
    Task {
      do {
        async let topRepo = worker.getRepositories(with: .stars, page: 1)
        async let lastUpdated = worker.getRepositories(with: .updated, page: 1)
        let (topRepoResponse, lastUpdatedtResponse) = try await (topRepo, lastUpdated)

        let topRepoViewModel = MapRepoViewModel(
          repositories: topRepoResponse.items, section: .topRepos)
        let lastUpdatedViewModel = MapRepoViewModel(
          repositories: lastUpdatedtResponse.items, section: .lastUpdated)
        let newsViewModel = MapNewsViewModel(
          topRepos: topRepoResponse.items, lastUpdated: lastUpdatedtResponse.items)

        let feedModel = FeedModel(
          news: newsViewModel, topRepos: topRepoViewModel, lastUpdated: lastUpdatedViewModel)

        state = .loaded(feedModel)
      } catch {

        state = .error(error.localizedDescription)
      }
    }
  }

}
