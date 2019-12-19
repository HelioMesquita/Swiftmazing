//
//  MainCollectionView.swift
//  Visual
//
//  Created by Hélio Mesquita on 19/12/19.
//  Copyright © 2019 Hélio Mesquita. All rights reserved.
//

import UIKit

open class MainCollectionView: BaseCollectionViewController {

    public init() {
        super.init(collectionViewLayout: MainCollectionView.configureLayout())
        setup()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    open func setup() {
        fatalError("setup has not been implemented")
    }

    override open func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(cellType: RepositoryMainCell.self)
        collectionView.collectionViewLayout = MainCollectionView.configureLayout()
    }

    static func configureLayout() -> UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.8), heightDimension: .fractionalHeight(0.33))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item, item, item])

        let section = NSCollectionLayoutSection(group: group)
        return UICollectionViewCompositionalLayout(section: section)
    }

}
