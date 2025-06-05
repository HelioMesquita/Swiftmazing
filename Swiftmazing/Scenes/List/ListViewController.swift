//
//  ListViewController.swift
//  Swiftmazing
//
//  Created by Hélio Mesquita on 14/12/19.
//  Copyright (c) 2019 Hélio Mesquita. All rights reserved.
//

import Combine
import CombineSchedulers
import UIComponents
import UIKit

class ListViewController: ListCollectionViewController<ListCellViewModel> {

  let viewModel: any ListViewModelProtocol
  private var cancellables = Set<AnyCancellable>()
  private let scheduler: AnySchedulerOf<DispatchQueue>

  init(
    listTitle: String,
    listFilter: RepositoriesRequest.Filter,
    listRepositories: [RepositoryModel],
    worker: RepositoriesWorkerProtocol = RepositoriesService(),
    sheduler: AnySchedulerOf<DispatchQueue> = DispatchQueue.main.eraseToAnyScheduler()
  ) {
    self.viewModel = ListViewModel(
      worker: worker,
      listTitle: listTitle,
      listFilter: listFilter,
      listRepositories: listRepositories)
    self.scheduler = sheduler
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
        case .loaded(let values):
          let model = values.repositories
          let title = values.title
          self.title = title
          var snapshot = NSDiffableDataSourceSnapshot<ListSection, ListCellViewModel>()
          snapshot.appendSections([.repo])
          snapshot.appendItems(model, toSection: .repo)
          self.dataSource.apply(snapshot, animatingDifferences: false)
          self.collectionView.refreshControl?.endRefreshing()

        case .error(let message):
          self.showTryAgain(title: Text.anErrorHappened.value, message: message)
        }
      }.store(in: &cancellables)

    viewModel.loadScreen()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    configure()
  }

  func configure() {
    collectionView.delegate = self
    collectionView.prefetchDataSource = self
    collectionView.refreshControl?.addTarget(self, action: #selector(load), for: .valueChanged)
  }

  @objc func load() {
    collectionView.refreshControl?.beginRefreshing()
    viewModel.reloadRepositories()
  }

  func presentViewController(_ vc: UIViewController) {
    self.navigationController?.pushViewController(vc, animated: true)
  }

}

extension ListViewController: UICollectionViewDelegate {

  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    guard let element = dataSource.itemIdentifier(for: indexPath)?.repository else { return }
    viewModel.repositorySelected(element)
  }

}

extension ListViewController: UICollectionViewDataSourcePrefetching {

  func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
    for indexPath in indexPaths {
      viewModel.prefetchNextPage(index: indexPath.row)
    }
  }

}

extension ListViewController: AlertDisplayProtocol {

  func reload() {
    load()
  }

}
