//
//  FeedViewModel.swift
//  Swiftmazing
//
//  Created by Hélio Mesquita on 13/05/25.
//

import Combine

enum States<T> {
  case loading
  case loaded(T)
  case error(String)
}

enum FeedNavigationAction {
  case list(repositories: [RepositoryModel], filter: RepositoriesFilter, title: String)
  case detail(RepositoryModel)
}

@MainActor
class FeedViewModel {

  @Published var state: States<FeedModel> = .loading
  let navigateToNextScreen = PassthroughSubject<FeedNavigationAction, Never>()
  let worker: RepositoriesWorkerProtocol

  init(worker: RepositoriesWorkerProtocol = RepositoriesWorker()) {
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

        let viewModel = FeedModel(
          news: newsViewModel, topRepos: topRepoViewModel, lastUpdated: lastUpdatedViewModel)

        state = .loaded(viewModel)
      } catch {

        state = .error(error.localizedDescription)
      }
    }
  }

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
