//
//  BaseTableViewController.swift
//  Visual
//
//  Created by Hélio Mesquita on 14/12/19.
//  Copyright © 2019 Hélio Mesquita. All rights reserved.
//

import UIKit

open class BaseTaleViewController: UITableViewController {

    override open func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.Design.background
        tableView.separatorColor = UIColor.Design.subtitle
    }

}
