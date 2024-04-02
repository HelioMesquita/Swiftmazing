//
//  UITableViewCell+UICollectionReusableView+Utils.swift
//  Visual
//
//  Created by Hélio Mesquita on 14/12/19.
//  Copyright © 2019 Hélio Mesquita. All rights reserved.
//

import UIKit

internal protocol ReusableView {
  static var reuseIdentifier: String { get }
}

extension ReusableView {

  public static var reuseIdentifier: String {
    return String(describing: self)
  }

}

extension UITableViewCell: ReusableView {}

extension UICollectionReusableView: ReusableView {}
