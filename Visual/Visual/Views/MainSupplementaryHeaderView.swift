//
//  MainSupplementaryHeaderView.swift
//  Visual
//
//  Created by Helio Loredo Mesquita on 23/12/19.
//  Copyright © 2019 Hélio Mesquita. All rights reserved.
//

import UIKit

public class MainSupplementaryHeaderView: UICollectionReusableView {

    private var designTitleColor = UIColor.Design.title
    private var designBackgroundColor = UIColor.Design.background
    private let padding: CGFloat = 30.0
    let label: UILabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: .zero)
        backgroundColor = designBackgroundColor
        label.textColor = designTitleColor
        label.font = .systemFont(ofSize: 21, weight: .bold)
        label.numberOfLines = 1
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            label.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding),
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
