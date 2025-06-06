//
//  RepoDetailViewModel.swift
//  Swiftmazing
//
//  Created by Hélio Mesquita on 22/05/25.
//

import Combine
import Foundation

enum RepositoryDetailNavigationAction {
  case openRepository(url: URL)
}

@MainActor
protocol RepoDetailViewModelProtocol: BaseViewModelProtocol where T == States<RepoDetailModel> {
  var navigateToNextScreen: PassthroughSubject<RepositoryDetailNavigationAction, Never> { get set }
  func openRepository()
}

class RepoDetailViewModel: RepoDetailViewModelProtocol {

  @Published var state: States<RepoDetailModel> = .loading
  var statePublisher: AnyPublisher<States<RepoDetailModel>, Never> {
    $state.eraseToAnyPublisher()
  }
  var navigateToNextScreen: PassthroughSubject<RepositoryDetailNavigationAction, Never> = .init()
  let repository: RepositoryModel

  init(repository: RepositoryModel) {
    self.repository = repository
  }

  func loadScreen() {
    var texts: [String] = []
    if let description = repository.description {
      texts.append(description)
    }
    texts.append(" - \(repository.stars.kiloFormat) \(Text.stars.value)")
    texts.append(" - \(repository.issues.kiloFormat) \(Text.issues.value) ")
    texts.append(" - \(repository.forks.kiloFormat) \(Text.forks.value) ")
    texts.append(" - \(Text.lastUpdate.value) \(repository.lastUpdate.monthDayYear)")

    let model = RepoDetailModel(
      image: repository.owner.avatar,
      title: repository.name,
      author: repository.owner.name,
      descriptions: texts,
      buttonTitle: Text.seeRepository.value)
    state = .loaded(model)
  }

  func openRepository() {
    navigateToNextScreen.send(.openRepository(url: repository.url))
  }

}
