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
protocol ListViewModelProtocol: BaseViewModelProtocol
where T == States<(repositories: [ListCellViewModel], title: String)> {
  var navigateToNextScreen: PassthroughSubject<ListNavigationAction, Never> { get set }
  func reloadRepositories()
  func repositorySelected(_ repository: RepositoryModel)
  func prefetchNextPage(index: Int)
}

@MainActor
class ListViewModel: ListViewModelProtocol {

  typealias ListLoaded = (repositories: [ListCellViewModel], title: String)

  let listTitle: String
  let listFilter: RepositoriesRequest.Filter
  let itemsPerPage: Int
  let worker: RepositoriesWorkerProtocol
  var listRepositories: [RepositoryModel]
  var currentPage: Int = 1

  @Published var state: States<ListLoaded> = .loading
  var statePublisher: AnyPublisher<States<ListLoaded>, Never> {
    $state.eraseToAnyPublisher()
  }

  var navigateToNextScreen: PassthroughSubject<ListNavigationAction, Never> = .init()

  init(
    worker: RepositoriesWorkerProtocol = RepositoriesService(),
    itemsPerPage: Int = RepositoriesRequest.itemsPerPage,
    listTitle: String,
    listFilter: RepositoriesRequest.Filter,
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
        let newlistRepositories = try await worker.getRepositories(
          with: listFilter, page: currentPage
        ).items
        listRepositories.append(contentsOf: newlistRepositories)
        loadScreen()
      } catch {
        state = .error(error.localizedDescription)
      }
    }
  }

}
