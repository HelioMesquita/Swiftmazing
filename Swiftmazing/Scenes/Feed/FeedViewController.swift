//
//  FeedViewController.swift
//  Swiftmazing
//
//  Created by Hélio Mesquita on 14/12/19.
//  Copyright (c) 2019 Hélio Mesquita. All rights reserved.
//

import Combine
import CombineSchedulers
import UIComponents
import UIKit

class FeedViewController: FeedCollectionViewController<FeedCellModel> {

  private let viewModel: any FeedViewModelProtocol
  private var cancellables = Set<AnyCancellable>()
  private let scheduler: AnySchedulerOf<DispatchQueue>

  init(
    viewModel: any FeedViewModelProtocol = FeedViewModel(),
    scheduler: AnySchedulerOf<DispatchQueue> = DispatchQueue.main.eraseToAnyScheduler()
  ) {
    self.viewModel = viewModel
    self.scheduler = scheduler
    super.init()
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    viewModel.navigateToNextScreen
      .receive(on: scheduler)
      .sink { action in
        switch action {
        case .list(let repositories, let filter, let title):
          let destinationViewController = ListViewController(
            listTitle: title,
            listFilter: filter,
            listRepositories: repositories)
          self.presentViewController(destinationViewController)

        case .detail(let repository):
          let repositoryDetailViewController = RepoDetailViewController(repository: repository)
          self.presentViewController(repositoryDetailViewController)

        }
      }.store(in: &cancellables)

    viewModel.statePublisher
      .receive(on: scheduler)
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

  func presentViewController(_ vc: UIViewController) {
    self.navigationController?.pushViewController(vc, animated: true)
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
