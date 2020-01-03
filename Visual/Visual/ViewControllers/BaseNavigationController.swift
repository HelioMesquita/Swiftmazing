//
//  BaseNavigationController.swift
//  Visual
//
//  Created by Hélio Mesquita on 02/01/20.
//  Copyright © 2020 Hélio Mesquita. All rights reserved.
//

import UIKit

public class BaseNavigationController: UINavigationController {

    public override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override public func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.isTranslucent = true
    }
    
}
