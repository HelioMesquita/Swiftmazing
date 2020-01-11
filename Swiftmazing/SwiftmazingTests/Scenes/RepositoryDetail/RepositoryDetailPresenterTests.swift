//
//  RepositoryDetailPresenterTests.swift
//  SwiftmazingTests
//
//  Created by Helio Loredo Mesquita on 09/01/20.
//  Copyright © 2020 Hélio Mesquita. All rights reserved.
//

import Quick
import Nimble

@testable import Swiftmazing
@testable import PromiseKit

class RepositoryDetailPresenterTests: QuickSpec {

    var sut: RepositoryDetailPresenter!
    var viewController: ViewControllerSpy!
    var repository: Repository!

    class ViewControllerSpy: RepositoryDetailDisplayLogic {

        var showImageCalled: Bool = false
        var showTitleCalled: Bool = false
        var showAuthorCalled: Bool = false
        var showDescriptionsCalled: Bool = false
        var showButtonTitleCalled: Bool = false

        func showImage(_ imageURL: URL) {
            showImageCalled = true
        }

        func showTitle(_ text: String) {
            showTitleCalled = true
        }

        func showAuthor(_ text: String) {
            showAuthorCalled = true
        }

        func showDescriptions(_ texts: [String]) {
            showDescriptionsCalled = true
        }

        func showButtonTitle(_ text: String) {
            showButtonTitleCalled = true
        }

    }

    override func spec() {
        super.spec()
        PromiseKit.conf.Q.map = nil
        PromiseKit.conf.Q.return = nil

        beforeEach {
            self.repository = Repositories().items.first

            self.viewController = ViewControllerSpy()
            self.sut = RepositoryDetailPresenter()
            self.sut.viewController = self.viewController
        }

        describe("#presentRepository") {
            beforeEach {
                self.sut.presentRepository(self.repository)
            }

            it("shows image") {
                expect(self.viewController.showImageCalled).to(beTrue())
            }

            it("shows title") {
                expect(self.viewController.showTitleCalled).to(beTrue())
            }

            it("shows author") {
                expect(self.viewController.showAuthorCalled).to(beTrue())
            }

            it("shows description") {
                expect(self.viewController.showDescriptionsCalled).to(beTrue())
            }

            it("shows button") {
                expect(self.viewController.showButtonTitleCalled).to(beTrue())
            }
        }
    }

}
