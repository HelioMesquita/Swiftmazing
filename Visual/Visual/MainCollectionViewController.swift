//
//  MainCollectionView.swift
//  Visual
//
//  Created by Hélio Mesquita on 19/12/19.
//  Copyright © 2019 Hélio Mesquita. All rights reserved.
//

import UIKit

open class MainCollectionViewController<T: Hashable>: BaseViewController {

    public enum Section: Int {
        case news
        case repositories
    }

    lazy public var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.register(cellType: RepositoryCell.self)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    lazy public var dataSource: UICollectionViewDiffableDataSource<Section, T> = UICollectionViewDiffableDataSource(collectionView: self.collectionView) { (collectionView, indexPath, identifier) -> UICollectionViewCell? in
        print(identifier)

        let cell: RepositoryCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.titleLabel.text = "\(indexPath.row)"

        return cell
    }

    override open func viewDidLoad() {
        super.viewDidLoad()
        addCollectionView()
    }

    private func addCollectionView() {
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        ])
    }

    private func createLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { (numberOfSection, _) -> NSCollectionLayoutSection? in
            guard let section = Section(rawValue: numberOfSection) else { return nil }
            switch section {
            case .news:
                return self.newsSection()
            case .repositories:
                return self.repositoriesSection()
            }
        }
    }

    private func newsSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                             heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .absolute(50))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                         subitems: [item])

        return NSCollectionLayoutSection(group: group)
    }

    private func repositoriesSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.3),
                                             heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .fractionalHeight(0.3))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                         subitem: item, count: 3)
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        return section
    }

}
