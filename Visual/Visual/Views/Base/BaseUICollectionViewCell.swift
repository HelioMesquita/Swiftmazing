//
//  BaseUICollectionViewCell.swift
//  Visual
//
//  Created by Hélio Mesquita on 08/01/20.
//  Copyright © 2020 Hélio Mesquita. All rights reserved.
//

import UIKit

public class BaseUICollectionViewCell: UICollectionViewCell {

    public override init(frame: CGRect) {
        super.init(frame: frame)
        let thisType = type(of: self)
        accessibilityIdentifier = String(describing: thisType)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
