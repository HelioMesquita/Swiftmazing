//
//  MainCollectionView.swift
//  Visual
//
//  Created by Hélio Mesquita on 19/12/19.
//  Copyright © 2019 Hélio Mesquita. All rights reserved.
//

import UIKit

public protocol FeedCollectionViewModelProtocol: BaseHashbleProtocol {
    var title: String { get }
    var subtitle: String? { get }
    var description: String { get }
    var images: [URL] { get }
}

public enum FeedSection: String, CaseIterable {
    case news
    case topRepos
    case lastUpdated
}

open class FeedCollectionViewController<T: FeedCollectionViewModelProtocol>: BaseViewController {

    private var headerHeight: NSCollectionLayoutDimension = .absolute(54)
    private var footerHeight: NSCollectionLayoutDimension = .absolute(32)
    private var groupWidth: NSCollectionLayoutDimension = .fractionalWidth(0.92)
    private var repositoriesItemHeight: NSCollectionLayoutDimension = .absolute(88)
    private var repositoriesGroupHeight: NSCollectionLayoutDimension = .absolute(256)
    private var newsGroupHeight: NSCollectionLayoutDimension = .estimated(312)
    private var padding: CGFloat = 5
    private lazy var contentInsets = NSDirectionalEdgeInsets(top: 0, leading: padding, bottom: 0, trailing: padding)

    private let header = FeedSupplementaryHeaderView.reuseIdentifier
    private let footer = FeedSupplementaryFooterView.reuseIdentifier
    private let numberOfElementsInReceiptGroup = 3

    lazy public var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.register(cellType: FeedNewsCell.self)
        collectionView.register(cellType: FeedRepositoryCell.self)
        collectionView.register(cellType: FeedSupplementaryHeaderView.self)
        collectionView.register(cellType: FeedSupplementaryFooterView.self)
        collectionView.backgroundColor = UIColor.Design.background
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.refreshControl = UIRefreshControl()
        return collectionView
    }()

    lazy public var dataSource: UICollectionViewDiffableDataSource<FeedSection, T> = {

        var dataSource = UICollectionViewDiffableDataSource<FeedSection, T>(collectionView: self.collectionView) { [weak self]  (collectionView, indexPath, element) -> UICollectionViewCell? in
            guard let `self` = self else { return nil }

            let sectionType = FeedSection.allCases[indexPath.section]
            switch sectionType {
            case .news:
                let cell: FeedNewsCell = collectionView.dequeueReusableCell(for: indexPath)
                cell.configure(element)
                return cell
            case .topRepos, .lastUpdated:
                let cell: FeedRepositoryCell = collectionView.dequeueReusableCell(for: indexPath)
                cell.configure(element, index: indexPath.row, numberOfElements: self.numberOfElementsInReceiptGroup)
                return cell
            }
        }

        dataSource.supplementaryViewProvider = { [weak self] (collectionView, kind, indexPath) -> UICollectionReusableView? in
            guard let `self` = self else { return nil }

            switch kind {
            case self.header:
                let headerView: FeedSupplementaryHeaderView = collectionView.dequeueReusableSupplementaryView(for: indexPath)
                headerView.configure(FeedSection.allCases[indexPath.section], callBack: self.didSelectSupplementaryHeaderView)
                return headerView
            case self.footer:
                let footerView: FeedSupplementaryFooterView = collectionView.dequeueReusableSupplementaryView(for: indexPath)
                return footerView
            default:
                return nil
            }
        }

        return dataSource
    }()

    override open func viewDidLoad() {
        super.viewDidLoad()
        addCollectionView()
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    open func didSelectSupplementaryHeaderView(_ section: FeedSection) {
       //override this method to get button action
    }

    private func addCollectionView() {
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func createLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { (sectionIndex, _) -> NSCollectionLayoutSection? in
            let section = FeedSection.allCases[sectionIndex]
            switch section {
            case .news:
                return self.newsSection()
            case .topRepos, .lastUpdated:
                return self.repositoriesSection()
            }
        }
    }

    private func repositoriesSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .completedWidth, heightDimension: repositoriesItemHeight)
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = contentInsets

        let groupSize = NSCollectionLayoutSize(widthDimension: groupWidth, heightDimension: repositoriesGroupHeight)
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item, count: numberOfElementsInReceiptGroup)

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPagingCentered
        section.boundarySupplementaryItems = [sectionHeader(), sectionFooter()]

        return section
    }

    private func newsSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .completedWidth, heightDimension: .completedHeight)
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: groupWidth, heightDimension: newsGroupHeight)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
        group.contentInsets = contentInsets

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPagingCentered
        section.boundarySupplementaryItems = [sectionFooter()]

        return section
    }

    private func sectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        let headerSize = NSCollectionLayoutSize(widthDimension: .completedWidth, heightDimension: headerHeight)
        return NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: header, alignment: .top)
    }

    private func sectionFooter() -> NSCollectionLayoutBoundarySupplementaryItem {
        let footerSize = NSCollectionLayoutSize(widthDimension: .completedWidth, heightDimension: footerHeight)
        return NSCollectionLayoutBoundarySupplementaryItem(layoutSize: footerSize, elementKind: footer, alignment: .bottom)
    }

}
