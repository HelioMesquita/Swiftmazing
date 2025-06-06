//
//  FeedSupplementaryHeaderView.swift
//  Visual
//
//  Created by Helio Loredo Mesquita on 23/12/19.
//  Copyright © 2019 Hélio Mesquita. All rights reserved.
//

import UIKit

public class FeedSupplementaryFooterView: UICollectionReusableView {

  private var designLineColor = UIColor.Design.line
  private var designBackgroundColor = UIColor.Design.background
  private let padding: CGFloat = 20.0
  private let line: UIView = UIView()

  override public init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = designBackgroundColor
    line.backgroundColor = designLineColor
    addSubview(line)
    line.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate([
      line.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
      line.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
      line.bottomAnchor.constraint(equalTo: bottomAnchor),
      line.heightAnchor.constraint(equalToConstant: 0.5),
    ])
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

}
