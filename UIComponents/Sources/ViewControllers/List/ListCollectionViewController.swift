//
//  ListCollectionViewController.swift
//  Visual
//
//  Created by Hélio Mesquita on 02/01/20.
//  Copyright © 2020 Hélio Mesquita. All rights reserved.
//

import UIKit

public protocol ListCollectionViewModelProtocol: BaseHashbleProtocol, Sendable {
  var title: String { get }
  var description: String { get }
  var additionalInfo: String { get }
  var supplementaryInfo: String { get }
  var image: URL? { get }
}

public enum ListSection: String, CaseIterable, Sendable {
  case repo
}

open class ListCollectionViewController<T: ListCollectionViewModelProtocol>: BaseViewController {

  private var repositoriesItemHeight: NSCollectionLayoutDimension = .absolute(118)
  private var padding: CGFloat = 20
  private lazy var contentInsets = NSDirectionalEdgeInsets(
    top: 0, leading: padding, bottom: 10, trailing: padding)

  lazy public var collectionView: UICollectionView = {
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
    collectionView.register(cellType: ListRepositoryCell.self)
    collectionView.backgroundColor = UIColor.Design.background
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    collectionView.showsVerticalScrollIndicator = false
    collectionView.showsHorizontalScrollIndicator = false
    collectionView.refreshControl = UIRefreshControl()
    return collectionView
  }()

  lazy public var dataSource: UICollectionViewDiffableDataSource<ListSection, T> = {

    var dataSource = UICollectionViewDiffableDataSource<ListSection, T>(
      collectionView: self.collectionView
    ) { [weak self] (collectionView, indexPath, element) -> UICollectionViewCell? in

      let cell: ListRepositoryCell = collectionView.dequeueReusableCell(for: indexPath)
      cell.configure(element)
      return cell
    }

    return dataSource
  }()

  override open func viewDidLoad() {
    super.viewDidLoad()
    addCollectionView()
    navigationItem.largeTitleDisplayMode = .never
  }

  private func addCollectionView() {
    view.addSubview(collectionView)
    NSLayoutConstraint.activate([
      collectionView.topAnchor.constraint(equalTo: view.topAnchor),
      collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
    ])
  }

  private func createLayout() -> UICollectionViewCompositionalLayout {
    let itemSize = NSCollectionLayoutSize(
      widthDimension: .completedWidth, heightDimension: repositoriesItemHeight)
    let item = NSCollectionLayoutItem(layoutSize: itemSize)
    item.contentInsets = contentInsets

    let groupSize = NSCollectionLayoutSize(
      widthDimension: .completedWidth, heightDimension: repositoriesItemHeight)
    let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

    let section = NSCollectionLayoutSection(group: group)

    return UICollectionViewCompositionalLayout(section: section)
  }

}
