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
        return lhs.name == rhs.name
    }

}

open class FeedCollectionViewController<T: FeedCollectionViewModelProtocol>: BaseViewController {

    public enum FeedSection: String, CaseIterable {
        case news
        case topRepos
        case lastUpdated
    }

    private let header = FeedSupplementaryHeaderView.reuseIdentifier
    private let footer = FeedSupplementaryFooterView.reuseIdentifier
    private var contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)

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
            let sectionType = FeedSection.allCases[indexPath.section]
            switch sectionType {
            case .news:
                let cell: FeedNewsCell = collectionView.dequeueReusableCell(for: indexPath)
                cell.configure(element)
                return cell
            case .topRepos, .lastUpdated:
                let cell: FeedRepositoryCell = collectionView.dequeueReusableCell(for: indexPath)
                cell.configure(element)
                return cell
            }
        }

        dataSource.supplementaryViewProvider = { [weak self] (collectionView, kind, indexPath) -> UICollectionReusableView? in
            guard let `self` = self else { return nil }

            switch kind {
            case self.header:
                let headerView: FeedSupplementaryHeaderView = collectionView.dequeueReusableSupplementaryView(for: indexPath)
                headerView.label.text = FeedSection.allCases[indexPath.section].rawValue
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
        return UICollectionViewCompositionalLayout { sectionIndex, _ -> NSCollectionLayoutSection? in
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
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.3))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = contentInsets

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .fractionalHeight(0.3))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item, count: 3)

        let itemSupplementarySize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(10))
        let itemSupplementary = NSCollectionLayoutSupplementaryItem(layoutSize: itemSupplementarySize, elementKind: footer, containerAnchor: NSCollectionLayoutAnchor(edges: .top), itemAnchor: NSCollectionLayoutAnchor(edges: .bottom))
        group.supplementaryItems = [itemSupplementary]

        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(44))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: FeedSupplementaryHeaderView.reuseIdentifier, alignment: .top)

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPagingCentered
        section.boundarySupplementaryItems = [sectionHeader]
        return section
    }

    private func newsSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = contentInsets

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .absolute(320))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)

        let footerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(33))
        let sectionFooter = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: footerSize, elementKind: FeedSupplementaryFooterView.reuseIdentifier, alignment: .bottom)

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPagingCentered
        section.boundarySupplementaryItems = [sectionFooter]

        return section
    }

}
