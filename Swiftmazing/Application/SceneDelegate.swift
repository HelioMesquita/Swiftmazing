//
//  SceneDelegate.swift
//  Swiftmazing
//
//  Created by Hélio Mesquita on 08/12/19.
//  Copyright © 2019 Hélio Mesquita. All rights reserved.
//

import UIKit
import Visual

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = SelectorViewController()
        window?.makeKeyAndVisible()
        window?.windowScene = windowScene
    }

}
