//
//  UICollectionView+Utils.swift
//  Visual
//
//  Created by Hélio Mesquita on 14/12/19.
//  Copyright © 2019 Hélio Mesquita. All rights reserved.
//

import UIKit

public extension UICollectionView {

    func register<T: UICollectionViewCell>(cellType: T.Type) {
        self.register(cellType.self, forCellWithReuseIdentifier: cellType.reuseIdentifier)
    }

    func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Unable to Dequeue Reusable Table View Cell")
        }

        return cell
    }

    func register<T: UICollectionReusableView>(cellType: T.Type) {
        self.register(cellType.self, forSupplementaryViewOfKind: cellType.reuseIdentifier, withReuseIdentifier: cellType.reuseIdentifier)
    }

    func dequeueReusableSupplementaryView<T: UICollectionReusableView>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableSupplementaryView(ofKind: T.reuseIdentifier, withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Unable to Dequeue Reusable Table View Cell")
        }

        return cell
    }

}
