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
        let navigationBarAppearence = UINavigationBarAppearance()
        navigationBarAppearence.shadowColor = .clear
        navigationBarAppearence.backgroundColor = UIColor.Design.background
        navigationBar.scrollEdgeAppearance = navigationBarAppearence
        navigationBar.isTranslucent = true
        navigationItem.largeTitleDisplayMode = .automatic
    }

    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }

}
