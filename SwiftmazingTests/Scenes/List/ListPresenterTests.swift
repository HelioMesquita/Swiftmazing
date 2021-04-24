//
//  ListPresenterTests.swift
//  SwiftmazingTests
//
//  Created by Helio Loredo Mesquita on 09/01/20.
//  Copyright © 2020 Hélio Mesquita. All rights reserved.
//

import Quick
import Nimble

@testable import Swiftmazing
@testable import PromiseKit

class ListPresenterTests: QuickSpec {

    var sut: ListPresenter!
    var viewController: ViewControllerSpy!

    class ViewControllerSpy: ListDisplayLogic {

        var showDetailCalled: Bool = false
        var showTitleCalled: Bool = false
        var showReloadCalled: Bool = false
        var showNextPageCalled: Bool = false
        var showTryAgainCalled: Bool = false

        func showTitle(_ title: String) {
            showTitleCalled = true
        }

        func showReload(with viewModels: [List.ListCellViewModel]) {
            showReloadCalled = true
        }
        func showNextPage(with viewModels: [List.ListCellViewModel]) {
            showNextPageCalled = true
        }

        func showDetail() {
            showDetailCalled = true
        }

        func showTryAgain(title: String, message: String) {
            showTryAgainCalled = true
        }

        func reload() {}

    }

    override func spec() {
        super.spec()

        beforeEach {
            self.viewController = ViewControllerSpy()
            self.sut = ListPresenter()
            self.sut.viewController = self.viewController
        }

        describe("presentTitle") {
            beforeEach {
                self.sut.presentTitle("")
            }

            it("calls show title") {
                expect(self.viewController.showTitleCalled).to(beTrue())
            }

        }
        describe("reloadMap") {
            beforeEach {
                self.sut.reloadMap(Repositories().items)
            }

            it("calls to reload screen") {
                expect(self.viewController.showReloadCalled).to(beTrue())
            }
        }

        describe("nextPageMap") {
            beforeEach {
                self.sut.nextPageMap(Repositories().items)
            }

            it("calls to show next page") {
                expect(self.viewController.showNextPageCalled).to(beTrue())
            }
        }

        describe("#presentDetail") {
            beforeEach {
                self.sut.presentDetail()
            }

            it("calls show list") {
                expect(self.viewController.showDetailCalled).to(beTrue())
            }
        }


        describe("#presentTryAgain") {
            beforeEach {
                self.sut.presentTryAgain(message: "")
            }

            context("when failure the request") {
                it("calls try again") {
                    expect(self.viewController.showTryAgainCalled).to(beTrue())
                }
            }
        }
    }

}

