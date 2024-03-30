//
//  NSCollectionLayoutDimension+Utils.swift
//  Visual
//
//  Created by Hélio Mesquita on 01/01/20.
//  Copyright © 2020 Hélio Mesquita. All rights reserved.
//

import UIKit

extension NSCollectionLayoutDimension {

  class var completedWidth: NSCollectionLayoutDimension {
    return .fractionalWidth(1.0)
  }

  class var completedHeight: NSCollectionLayoutDimension {
    return .fractionalHeight(1.0)
  }

}
