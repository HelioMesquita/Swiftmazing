//
//  MainCollectionView.swift
//  Visual
//
//  Created by Hélio Mesquita on 19/12/19.
//  Copyright © 2019 Hélio Mesquita. All rights reserved.
//

import UIKit

public enum FeedCollectionViewCell {
    case news
    case repositories
}

public protocol FeedCollectionViewModelProtocol: Hashable {
    var id: String { get }
    var cellType: FeedCollectionViewCell { get set }
    var title: String? { get }
    var name: String { get }
    var description: String { get }
    var images: [URL] { get }

    func hash(into hasher: inout Hasher)
}

public extension FeedCollectionViewModelProtocol {

    var id: String {
        return UUID().uuidString
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.id == rhs.id
    }

}

public enum FeedSection: String, CaseIterable {
    case news
    case topRepos
    case lastUpdated
}

open class FeedCollectionViewController<T: FeedCollectionViewModelProtocol>: BaseViewController {

    private let header = FeedSupplementaryHeaderView.reuseIdentifier
    private let footer = FeedSupplementaryFooterView.reuseIdentifier
    private var contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)
    private let numberOfElementsInReceiptGroup = 3

    lazy public var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.register(cellType: FeedNewsCell.self)
        collectionView.register(cellType: FeedRepositoryCell.self)
        collectionView.register(cellType: FeedSupplementaryHeaderView.self)
        collectionView.register(cellType: FeedSupplementaryFooterView.self)
        collectionView.backgroundColor = UIColor.Design.background
        collectionView.translatesAutoresizingMaskIntoConstraints = false
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
    }

    open func didSelectSupplementaryHeaderView(_ section: FeedSection) {
       //override this method to get button action
    }

    private func addCollectionView() {
        view.addSubview(collectionView)
        let guide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: guide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: guide.bottomAnchor),
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
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(80))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = contentInsets

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .absolute(240))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item, count: numberOfElementsInReceiptGroup)

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPagingCentered
        section.boundarySupplementaryItems = [sectionHeader(), sectionFooter()]

        return section
    }

    private func newsSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = contentInsets

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .absolute(320))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPagingCentered
        section.boundarySupplementaryItems = [sectionFooter()]

        return section
    }

    private func sectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(40))
        return NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: header, alignment: .top)
    }

    private func sectionFooter() -> NSCollectionLayoutBoundarySupplementaryItem {
        let footerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(24))
        return NSCollectionLayoutBoundarySupplementaryItem(layoutSize: footerSize, elementKind: footer, alignment: .bottom)
    }

}

internal extension String {

    static let seeMore = "seeMore".localized()

}
