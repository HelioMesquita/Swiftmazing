//
//  FeedPresenterTests.swift
//  SwiftmazingTests
//
//  Created by Helio Loredo Mesquita on 09/01/20.
//  Copyright © 2020 Hélio Mesquita. All rights reserved.
//

import Quick
import Nimble

@testable import Swiftmazing
@testable import PromiseKit

class FeedPresenterTests: QuickSpec {

    var sut: FeedPresenter!
    var viewController: ViewControllerSpy!

    class ViewControllerSpy: FeedDisplayLogic {
        var showCalled: Bool = false
        var showListCalled: Bool = false
        var showDetailCalled: Bool = false
        var showTryAgainCalled: Bool = false

        func show(_ viewModel: Feed.ViewModel) {
            showCalled = true
        }

        func showList() {
            showListCalled = true
        }

        func showDetail() {
            showDetailCalled = true
        }

        func showTryAgain(title: String, message: String) {
            showTryAgainCalled = true
        }

        func reload() {}

    }

    override class func spec() {
        super.spec()

        beforeEach {
            self.viewController = ViewControllerSpy()
            self.sut = FeedPresenter()
            self.sut.viewController = self.viewController
        }

        describe("#mapResponse") {
            beforeEach {
                self.sut.mapResponse(Repositories(), Repositories())
            }

            context("when has received the request") {
                it("calls show method") {
                    expect(self.viewController.showCalled).to(beTrue())
                }
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

        describe("#presentList") {
            beforeEach {
                self.sut.presentList()
            }

            it("calls show list") {
                expect(self.viewController.showListCalled).to(beTrue())
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
    }

}

