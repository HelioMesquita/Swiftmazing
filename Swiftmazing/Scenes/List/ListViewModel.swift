//
//  ListViewModel.swift
//  Swiftmazing
//
//  Created by Hélio Mesquita on 22/05/25.
//

import Combine

enum ListNavigationAction {
  case detail(RepositoryModel)
}

@MainActor
class ListViewModel {

  typealias ListLoaded = (repositories: [ListCellViewModel], title: String)

  let listTitle: String
  let listFilter: RepositoriesFilter
  let itemsPerPage: Int
  let worker: RepositoriesWorker
  var listRepositories: [RepositoryModel]
  var currentPage: Int = 1

  @Published var state: States<ListLoaded> = .loading
  let navigateToNextScreen = PassthroughSubject<ListNavigationAction, Never>()

  init(
    worker: RepositoriesWorker = RepositoriesWorker(),
    itemsPerPage: Int = RepositoriesProvider.itemsPerPage,
    listTitle: String,
    listFilter: RepositoriesFilter,
    listRepositories: [RepositoryModel]
  ) {
    self.worker = worker
    self.itemsPerPage = itemsPerPage
    self.listTitle = listTitle
    self.listFilter = listFilter
    self.listRepositories = listRepositories
  }

  func loadScreen() {
    let items = ListMapRepoViewModel(repositories: listRepositories).items
    state = .loaded((items, listTitle))
  }

  func reloadRepositories() {
    currentPage = 1
    listRepositories.removeAll()
    loadRepositories()
  }

  func repositorySelected(_ repository: RepositoryModel) {
    navigateToNextScreen.send(.detail(repository))
  }

  func prefetchNextPage(index: Int) {
    let indexAdjusted = index + 1
    let totalItems = currentPage * itemsPerPage
    if indexAdjusted == totalItems {
      currentPage += 1
      loadRepositories()
    }
  }

  private func loadRepositories() {
    Task {
      do {
        let newlistRepositories = try await worker.getRepositories(with: listFilter, page: currentPage).items
        listRepositories.append(contentsOf: newlistRepositories)
        loadScreen()
      } catch {
        state = .error(error.localizedDescription)
      }
    }
  }

}
