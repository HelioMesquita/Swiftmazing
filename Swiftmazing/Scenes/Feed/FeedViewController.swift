//
//  FeedViewController.swift
//  Swiftmazing
//
//  Created by Hélio Mesquita on 14/12/19.
//  Copyright (c) 2019 Hélio Mesquita. All rights reserved.
//
 
import Combine
import UIKit
import UIComponents

class FeedViewController: FeedCollectionViewController<FeedCellModel> {

  private let viewModel = FeedViewModel()
  private var cancellables = Set<AnyCancellable>()

  override func viewDidLoad() {
    super.viewDidLoad()

    viewModel.navigateToNextScreen
      .sink { action in
        switch action {
        case .list(let repositories, let filter, let title):
          let destinationViewController = ListViewController(
            listTitle: title,
            listFilter: filter,
            listRepositories: repositories)
          self.navigationController?.pushViewController(destinationViewController, animated: true)

        case .detail(let repository):
          let repositoryDetailViewController = RepositoryDetailViewController(repository: repository)
          self.navigationController?.pushViewController(repositoryDetailViewController, animated: true)

        }
      }.store(in: &cancellables)

    viewModel.$state
      .receive(on: RunLoop.main)
      .sink { states in
      switch states {
      case .loading:
        break
      case .loaded(let model):
        var snapshot = NSDiffableDataSourceSnapshot<FeedSection, FeedCellModel>()
        snapshot.appendSections([.news, .topRepos, .lastUpdated])
        snapshot.appendItems(model.news, toSection: .news)
        snapshot.appendItems(model.topRepos, toSection: .topRepos)
        snapshot.appendItems(model.lastUpdated, toSection: .lastUpdated)
        self.dataSource.apply(snapshot, animatingDifferences: false)
        self.collectionView.refreshControl?.endRefreshing()
      case .error(let message):
        self.showTryAgain(title: Text.anErrorHappened.value, message: message)
      }
    }.store(in: &cancellables)

    configure()
    load()
  }

  private func configure() {
    title = Bundle.main.displayName
    collectionView.delegate = self
    collectionView.refreshControl?.addTarget(self, action: #selector(load), for: .valueChanged)
  }

  @objc func load() {
    collectionView.refreshControl?.beginRefreshing()
    viewModel.loadScreen()
  }

  override func didSelectSupplementaryHeaderView(_ section: FeedSection) {
    didSelectSection(section)
  }

  func didSelectSection(_ section: FeedSection) {
    let repositories = dataSource.snapshot().itemIdentifiers(inSection: section).compactMap {
      $0.repository
    }
    switch section {
    case .topRepos:
      viewModel.topRepoListSelected(repositories, title: section.value)
    case .lastUpdated:
      viewModel.lastUpdatedListSelected(repositories, title: section.value)
    default:
      return
    }
  }

}

extension FeedViewController: UICollectionViewDelegate {

  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

    guard let element = dataSource.itemIdentifier(for: indexPath) else { return }
    if let repository = element.repository {
      viewModel.repositorySelected(repository)
    } else {
      didSelectSection(element.section)
    }
  }

}

extension FeedViewController: AlertDisplayProtocol {

  func reload() {
    load()
  }

}
