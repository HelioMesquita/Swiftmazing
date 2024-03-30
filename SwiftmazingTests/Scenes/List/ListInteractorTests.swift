//
//  FeedInteractorTests.swift
//  SwiftmazingTests
//
//  Created by Helio Loredo Mesquita on 09/01/20.
//  Copyright © 2020 Hélio Mesquita. All rights reserved.
//

import Quick
import Nimble

@testable import Swiftmazing
@testable import PromiseKit

class ListInteractorTests: QuickSpec {

    var sut: ListInteractor!
    var presenter: PresenterSpy!
    var worker: RepositoriesWorkerSpy!
    var repositories: [Repository]!
    var repository: Repository!

    class PresenterSpy: ListPresentationLogic {

        var presentTitleCalled: Bool = false
        var reloadMapCalled: Bool = false
        var nextPageMapCalled: Bool = false
        var presentDetailCalled: Bool = false
        var presentTryAgainCalled: Bool = false

        func presentTitle(_ title: String) {
            presentTitleCalled = true
        }

        func reloadMap(_ repositories: [Repository]) {
            reloadMapCalled = true
        }

        func nextPageMap(_ repositories: [Repository]) {
            nextPageMapCalled = true
        }

        func presentDetail() {
            presentDetailCalled = true
        }

        func presentTryAgain(message: String) {
            presentTryAgainCalled = true
        }

    }

    override class func spec() {
        super.spec()
        PromiseKit.conf.Q.map = nil
        PromiseKit.conf.Q.return = nil

        beforeEach {
            self.repositories = Repositories().items
            self.repository = Repositories().items.first

            self.worker = RepositoriesWorkerSpy()
            self.presenter = PresenterSpy()
            self.sut = ListInteractor(worker: self.worker)
            self.sut.presenter = self.presenter
        }

        describe("#loadScreen") {
            context("when the screen loads") {
                beforeEach {
                    self.sut.loadScreen()
                }

                it("calls to presenter show the title") {
                    expect(self.presenter.presentTitleCalled).to(beTrue())
                }

                it("calls to presenter map the response") {
                    expect(self.presenter.reloadMapCalled).to(beTrue())
                }
            }
        }

        describe("#reloadRepositories") {
            context("when is pulled to refresh") {
                context("perform the request") {
                    context("successful request") {
                        beforeEach {
                            self.sut.reloadRepositories()
                        }

                        it("sets the current page to 1") {
                            expect(self.sut.currentPage).to(equal(1))
                        }

                        it("calls to presenter map the response") {
                            expect(self.presenter.reloadMapCalled).to(beTrue())
                        }
                    }

                    context("unsuccessful request") {
                        beforeEach {
                            self.worker.isSuccess = false
                            self.sut.reloadRepositories()
                        }

                        it("sets the current page to 1") {
                            expect(self.sut.currentPage).to(equal(1))
                        }

                        it("presents try again") {
                            expect(self.presenter.presentTryAgainCalled).to(beTrue())
                        }
                    }
                }

            }
        }

        describe("#repositorySelected") {
            context("when is selected a repository cell") {
                beforeEach {
                    self.sut.repositorySelected(self.repository)
                }

                it("saves the selected repository") {
                    expect(self.sut.selectedRepository) === self.repository

                }

                it("calls to presenter show the detail") {
                    expect(self.presenter.presentDetailCalled).to(beTrue())
                }
            }
        }

        describe("#prefetchNextPage") {
            context("when the list is in the middle") {
                beforeEach {
                    self.sut.prefetchNextPage(index: 5)
                }
                it("does not get to next page") {
                    expect(self.presenter.nextPageMapCalled).to(beFalse())
                }
            }

            context("when finished the list") {
                context("perform the request") {
                    context("successful request") {
                        beforeEach {
                            self.sut.prefetchNextPage(index: 9)
                        }

                        it("calls to presenter map the response") {
                            expect(self.presenter.nextPageMapCalled).to(beTrue())
                        }

                        it("increases the current page by one") {
                            expect(self.sut.currentPage).to(equal(2))
                        }
                    }

                    context("unsuccessful request") {
                        beforeEach {
                            self.worker.isSuccess = false
                            self.sut.prefetchNextPage(index: 9)
                        }

                        it("presents try again") {
                            expect(self.presenter.presentTryAgainCalled).to(beTrue())
                        }
                    }
                }

            }
        }



    }

}
