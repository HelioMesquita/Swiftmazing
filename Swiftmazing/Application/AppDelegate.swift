//
//  AppDelegate.swift
//  Swiftmazing
//
//  Created by Hélio Mesquita on 08/12/19.
//  Copyright © 2019 Hélio Mesquita. All rights reserved.
//

import UIKit
import Flutter

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    lazy var flutterEngine = FlutterEngine(name: "dartmazing")

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        flutterEngine.run()

        GeneratedPluginRegistrant.register(with: self.flutterEngine)
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

}
