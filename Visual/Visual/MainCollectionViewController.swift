//
//  MainCollectionView.swift
//  Visual
//
//  Created by Hélio Mesquita on 19/12/19.
//  Copyright © 2019 Hélio Mesquita. All rights reserved.
//

import UIKit

public enum MainCollectionViewCell {
    case news
    case repositories
}

public protocol MainCollectionViewModelProtocol: Hashable {
    var id: String { get }
    var cellType: MainCollectionViewCell { get set }
    var title: String? { get }
    var name: String { get }
    var description: String { get }
    var image: URL? { get }

    func hash(into hasher: inout Hasher)
}

public extension MainCollectionViewModelProtocol {

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

open class MainCollectionViewController<T: MainCollectionViewModelProtocol>: BaseViewController {

    public enum Section: Int {
        case news
        case repositories
    }

    private var contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)

    lazy public var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.register(cellType: RepositoryCell.self)
//        collectionView.backgroundColor = UIColor.Design.background
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    lazy public var dataSource: UICollectionViewDiffableDataSource<Section, T> = UICollectionViewDiffableDataSource(collectionView: self.collectionView) { (collectionView, indexPath, element) -> UICollectionViewCell? in
        
        let cell: RepositoryCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.configure(element)

        return cell
    }

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

    private func repositoriesSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.3))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = contentInsets

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .fractionalHeight(0.3))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item, count: 3)

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPagingCentered
        return section
    }

    private func newsSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = contentInsets

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .fractionalHeight(0.35))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPagingCentered
        return section
    }

}
