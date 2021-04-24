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

class FeedInteractorTests: QuickSpec {

    var sut: FeedInteractor!
    var presenter: PresenterSpy!
    var worker: RepositoriesWorkerSpy!
    var repositories: [Repository]!
    var repository: Repository!

    class PresenterSpy: FeedPresentationLogic {

        var mapResponseCalled = false
        var presentListCalled = false
        var presentDetailCalled = false
        var presentTryAgainCalled = false

        func mapResponse(_ topRepoResponse: Repositories, _ mostRecentResponse: Repositories) {
            mapResponseCalled = true
        }

        func presentList() {
            presentListCalled = true
        }

        func presentDetail() {
            presentDetailCalled = true
        }

        func presentTryAgain(message: String) {
            presentTryAgainCalled = true
        }

    }

    override func spec() {
        super.spec()
        PromiseKit.conf.Q.map = nil
        PromiseKit.conf.Q.return = nil

        beforeEach {
            self.repositories = Repositories().items
            self.repository = Repositories().items.first

            self.worker = RepositoriesWorkerSpy()
            self.presenter = PresenterSpy()
            self.sut = FeedInteractor(worker: self.worker)
            self.sut.presenter = self.presenter
        }

        describe("#loadScreen") {
            context("when successful request") {
                beforeEach {
                    self.sut.loadScreen()
                }

                it("calls to presenter map the response") {
                    expect(self.presenter.mapResponseCalled).to(beTrue())
                }
            }

            context("when unsuccessful request") {
                beforeEach {
                    self.worker.isSuccess = false
                    self.sut.loadScreen()
                }

                it("presents try again") {
                    expect(self.presenter.presentTryAgainCalled).to(beTrue())
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

        describe("#topRepoListSelected") {
            context("when is selected a news cell or see more") {
                beforeEach {
                    self.sut.topRepoListSelected(self.repositories, title: "title")
                }

                it("saves the repositories") {
                    expect(self.sut.listRepositories) === self.repositories
                }

                it("saves the filter selected") {
                    expect(self.sut.listFilter).to(equal(.stars))
                }

                it("saves the title") {
                    expect(self.sut.listTitle).to(equal("title"))
                }

                it("calls to presenter show the list") {
                    expect(self.presenter.presentListCalled).to(beTrue())
                }
            }
        }

        describe("#lastUpdatedListSelected") {
            context("when is selected a news cell or see more") {
                beforeEach {
                    self.sut.lastUpdatedListSelected(self.repositories, title: "title")
                }

                it("saves the repositories") {
                    expect(self.sut.listRepositories) === self.repositories
                }

                it("saves the filter selected") {
                    expect(self.sut.listFilter).to(equal(.updated))
                }

                it("saves the title") {
                    expect(self.sut.listTitle).to(equal("title"))
                }

                it("calls to presenter show the list") {
                    expect(self.presenter.presentListCalled).to(beTrue())
                }
            }
        }

    }

}
