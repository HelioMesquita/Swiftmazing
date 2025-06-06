//
//  BaseViewController.swift
//  Visual
//
//  Created by Hélio Mesquita on 14/12/19.
//  Copyright © 2019 Hélio Mesquita. All rights reserved.
//

import UIKit

open class BaseViewController: UIViewController {

  public init() {
    super.init(nibName: nil, bundle: nil)
  }

  required public init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  override open func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = UIColor.Design.background
  }

}
