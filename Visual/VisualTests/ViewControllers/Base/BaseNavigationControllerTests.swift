//
//  ListCollectionViewControllerTests.swift
//  VisualTests
//
//  Created by Hélio Mesquita on 06/01/20.
//  Copyright © 2020 Hélio Mesquita. All rights reserved.
//

import Quick
import Nimble
import Nimble_Snapshots

@testable import Visual

class BaseNavigationControllerTests: QuickSpec {

    override func spec() {

        var window: UIWindow!

        describe("BaseNavigationController") {

            beforeEach {
                let viewController = UIViewController()
                viewController.view.backgroundColor = .red
                viewController.title = "Title"

                let nav = BaseNavigationController(rootViewController: viewController)
                window = UIWindow(frame: CGRect(x: 0, y: 0, width: 375, height: 667))
                window.makeKeyAndVisible()
                window.rootViewController = nav
            }

            it("returns the layout") {
//                expect(window).to(recordDynamicSizeSnapshot(sizes: sizes))
                expect(window).to(haveValidDynamicSizeSnapshot(sizes: sizes))
            }
        }
    }
}
